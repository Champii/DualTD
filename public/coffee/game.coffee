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
  'socket'
  'gameService'
  'userService'
  ($http, socket, gameService, userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'game-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService
        scope.gameService = gameService

        StartGame socket.socket

    }
]
