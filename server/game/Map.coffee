async = require 'async'

bus = require '../bus'

MainTowerResource = require '../resources/MainTowerResource'
SpawnTowerResource = require '../resources/SpawnTowerResource'

###

0: empty
1: main tower
2: base tower
3: attack tower
4: spawn tower

###

class Map

  constructor: (players) ->

    # Create map
    @map = size: {x: 40, y: 20}, tiles: []
    for i in [0..@map.size.x]
      @map.tiles[i] = []
      for j in [0..@map.size.y]
        @map.tiles[i][j] = null

    bus.emit 'sendToAll', 'map', @ToJSON()

    # Create 2 MainTower
    async.auto
      oneCreate:                 (done)          -> MainTowerResource.Deserialize {pos: {x: 2, y: 10}, userId: players[0].id}, done
      oneSave:    ['oneCreate',  (done, results) -> results.oneCreate.Save done]
      twoCreate:                 (done)          -> MainTowerResource.Deserialize {pos: {x: 38, y: 10}, userId: players[1].id}, done
      twoSave:    ['twoCreate',  (done, results) -> results.twoCreate.Save done]
    , (err, results) =>
      return console.error err if err?

      @map.tiles[5][10] = @['mainTarget' + players[1].id] = results.oneSave
      @map.tiles[35][10] = @['mainTarget' + players[0].id] = results.twoSave


    # On newTower event
    bus.on 'newTower', (tower) =>
      toBuild = null
      switch tower.name
        when 'spawnTower' then toBuild = SpawnTowerResource

      tower.mainTargetPos = @['mainTarget' + tower.userId].pos
      toBuild.Deserialize tower, (err, tower) =>
        return console.error err if err?

        tower.Save (err) =>
          return console.error err if err?

          @map.tiles[tower.pos.x][tower.pos.y] = tower


  ToJSON: ->
    size: @map.size
    tiles: @_arrayToJSON @map.tiles

  _arrayToJSON: (array) ->
    res = []
    for v, k in array
      for v2, k2 in v
        res[k] = [] if not res[k]?

        if v2? and v2.ToJSON?
          res[k][k2] = v2.ToJSON()
        else
          res[k][k2] = null
    res

module.exports = Map
