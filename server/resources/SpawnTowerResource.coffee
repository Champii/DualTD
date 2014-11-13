bus = require '../bus'

TowerResource = require './TowerResource'
UnitResource = require './UnitResource'

class SpawnTowerResource extends TowerResource.Extend 'spawnTower', TowerResource.TowerRoute

  constructor: (blob) ->
    super blob
    @life = 100 if not @life?
    @name = 'spawnTower' if not @name?
    @Start()

  Start: ->
    UnitResource.Spawn
      pos: @pos
      userId: @userId
    @_spawnTimer = setInterval =>
      console.log 'Unit spawn'
      UnitResource.Spawn
        pos: @pos
        userId: @userId
    , 10000

SpawnTowerResource.Init()

module.exports = SpawnTowerResource
