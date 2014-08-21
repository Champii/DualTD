dualtd.directive 'dtdGame', [
  'userService'
  (userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'game-tpl'

      link: (scope, elem, attr) ->

        scope.userService = userService

    }
]
