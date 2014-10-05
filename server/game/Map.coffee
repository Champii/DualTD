bus = require '../bus'

MainTower = require './Tower/MainTower'

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

    @map.tiles[5][10] = new MainTower {x: 5, y: 10}, players[0].id
    @map.tiles[35][10] = new MainTower {x: 35, y: 10}, players[1].id

    bus.emit 'sendToAll', 'map', @map

module.exports = Map
