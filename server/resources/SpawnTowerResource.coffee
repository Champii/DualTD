bus = require '../bus'

TowerResource = require './TowerResource'

class SpawnTowerResource extends TowerResource.Extend 'spawnTower', TowerResource.TowerRoute

  constructor: (blob) ->
    super blob
    @life = 100 if not @life?
    @name = 'spawnTower' if not @name?

SpawnTowerResource.Init()

module.exports = SpawnTowerResource
