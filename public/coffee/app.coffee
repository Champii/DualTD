dualtd.directive 'dtdApp', [
  'roomService'
  'userService'
  'gameService'
  (roomService, userService, gameService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'app-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService
        scope.roomService = roomService
        scope.gameService = gameService

    }
]
