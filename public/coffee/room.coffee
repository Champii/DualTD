dualtd.service 'roomService', [
  '$http'
  'socket'
  'userService'
  ($http, socket, userService) ->

    @list = []
    @current = null

    @inRoom = false

    socket.on 'playersEnterRoom', (room, players) =>
      @current = room
      @list = players
      @inRoom = true

    socket.on 'playerLeaveRoom', (player) =>
      @list = _(@list).reject (item) -> item.id is player.id
      if player.id is userService.current.id
        @inRoom = false

    # TEMP TEST
    # $http.get('/api/1/rooms/1')
    #   .success (data) =>
    #     console.log 'lol', data
    #     @current = data
    #     @list = data.players

    @current = {id: 1}

    @
]

dualtd.directive 'dtdRoom', [
  '$http'
  'roomService'
  'userService'
  ($http, roomService, userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'room-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService
        scope.roomService = roomService

        scope.message = ''
        scope.waiting = false

        scope.start = ->
          $http.post('/api/1/rooms/' + scope.roomService.current.id + '/start')
            .success ->
              scope.waiting = true
              scope.message = 'Waiting for other player'

        scope.leave = ->

        setTimeout ->
          scope.$apply ->
            scope.start()
        , 1000

    }
]
