dualtd.directive 'dtdIncome', [
  'socket'
  (socket) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'income-tpl'

      link: (scope, elem, attr) ->

        scope.gold = 0

        socket.on 'income', (gold) ->
          scope.gold = gold

    }
]
