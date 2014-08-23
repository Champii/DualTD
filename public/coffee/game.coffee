dualtd.service 'gameService', [
  '$http'
  'socket'
  'userService'
  ($http, socket, userService) ->

    @current = null

    @inGame = false

    socket.on 'startGame', =>
      @inGame = true

    @
]

dualtd.directive 'dtdGame', [
  '$http'
  'gameService'
  'userService'
  ($http, gameService, userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'game-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService
        scope.gameService = gameService

        scope.message = ''
        scope.waiting = false

        scope.start = ->
          $http.post('/api/1/rooms/' + scope.gameService.current.id + '/start')
            .success ->
              scope.waiting = true
              scope.message = 'Waiting for other player'


        scope.leave = ->

    }
]
