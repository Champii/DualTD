TowerResource = require './TowerResource'
bus = require '../bus'

class MainTowerResource extends TowerResource.Extend 'spawnTower', TowerResource.TowerRoute

  constructor: (blob) ->
    super blob
    @life = 100 if not @life?
    @name = 'mainTower' if not @name?

MainTowerResource.Init()

module.exports = MainTowerResource
