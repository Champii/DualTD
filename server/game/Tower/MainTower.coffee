ATower = require './ATower'

class MainTower extends ATower

  constructor: (@pos, @player) ->
    super 100
    @name = 'mainTower'


module.exports = MainTower
