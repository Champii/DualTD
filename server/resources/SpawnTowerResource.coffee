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
    # @_spawnTimer = setInterval =>
    #   console.log 'Unit spawn'
    #   UnitResource.Spawn
    #     pos: @pos
    #     userId: @userId
    #     mainTargetPos: @mainTargetPos
    #     towerPos: @pos
    # , 20000

    #TEST
    UnitResource.Spawn
      pos: @pos
      userId: @userId
      mainTargetPos: @mainTargetPos
      towerPos: @pos

SpawnTowerResource.Init()

module.exports = SpawnTowerResource
