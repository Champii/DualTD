ATower = require './ATower'

class MainTower extends ATower

  constructor: (@position, @playerId) ->
    super 100
    @name = 'MainTower'

module.exports = MainTower
