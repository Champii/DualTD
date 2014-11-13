dualtd.directive 'dtdBank', [
  'socket'
  (socket) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'bank-tpl'

      link: (scope, elem, attr) ->

        scope.gold = 0
        scope.income = 0

        socket.on 'income', (bank) ->
          scope.gold = bank.gold
          scope.income = bank.income

    }
]
