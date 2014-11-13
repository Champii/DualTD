util = require 'util'

bus = require '../bus'

MainTower = require './Tower/MainTower'
SpawnTower = require './Tower/SpawnTower'

###

0: empty
1: main tower
2: base tower
3: attack tower
4: spawn tower

###

class Map

  constructor: (players) ->

    @map = size: {x: 40, y: 20}, tiles: []
    for i in [0..@map.size.x]
      @map.tiles[i] = []
      for j in [0..@map.size.y]
        @map.tiles[i][j] = null

    @map.tiles[5][10] = new MainTower {x: 5, y: 10}, players[0]
    @map.tiles[35][10] = new MainTower {x: 35, y: 10}, players[1]

    bus.on 'newTower', (tower) =>
      toBuild = null
      switch tower.name
        when 'spawnTower' then toBuild = new SpawnTower tower.pos, players[tower.userId - 1]

      @map.tiles[tower.pos.x][tower.pos.y] = toBuild

    bus.emit 'sendToAll', 'map', @ToJSON()

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
