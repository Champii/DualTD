ATower = require './ATower'

class MainTower extends ATower

  constructor: (@playerId) ->
    super 100
    @name = 'MainTower'

module.exports = MainTower
