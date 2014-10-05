dualtd.service 'lobbyService', [
  '$http'
  'socket'
  'userService'
  ($http, socket, userService) ->

    @list = []

    socket.on 'playerEnterLobby', (player) =>
      if userService.current.id isnt player.id
        @list.push player

    socket.on 'playerLeaveLobby', (player) =>
      @list = _(@list).reject (item) -> item.id is player.id

    @Fetch = ->
      $http.get('/api/1/lobbys')
        .success (data) =>
          @list = data

    @
]

dualtd.directive 'dtdLobby', [
  '$http'
  'lobbyService'
  'userService'
  ($http, lobbyService, userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'lobby-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService
        scope.lobbyService = lobbyService

        scope.message = ''
        scope.waiting = false

        scope.lobbyService.Fetch()

        scope.randomGame = ->
          $http.post('/api/1/lobbys/random')
            .success ->
              scope.message = 'Waiting for player...'
              scope.waiting = true
            .error (data) ->
              scope.message = 'Error: ' + data


    }
]
