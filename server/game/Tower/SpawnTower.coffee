bus = require '../../bus'

ATower = require './ATower'

class SpawnTower extends ATower

  constructor: (@pos, @player) ->
    super 100
    @name = 'spawnTower'

    bus.emit 'sendToAll', 'newTower', @ToJSON()

module.exports = SpawnTower
