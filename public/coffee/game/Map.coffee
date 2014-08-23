class Map

  constructor: (@mainContainer, @socket) ->
    @tileSize = 20

    @socket.on 'map', (map) =>
      for i in [0..map.size.x]
        for j in [0..map.size.y]
          if map.tiles[i][j] is null
            floorShape = new Kinetic.Rect
              x: i * @tileSize
              y: j * @tileSize
              width: @tileSize
              height: @tileSize
              fill: @GetTileColor map.tiles[i][j]
              stroke: 'black'
              lineWidth: 1

            floorShape.on 'mousedown', (e) =>
              if e.button == 2
                e.cancelBubble = true
                # @ShowContextMenu()

            @mainContainer.add floorShape

          else if map.tiles[i][j].name is 'MainTower'
            map.tiles[i][j] = new MainTower @mainContainer, map.tiles[i][j]

      @mainContainer.draw()

  GetTileColor: (tile) ->
    if tile is null
      return 'grey'
    else if tile.name is 'MainTower'
      return 'red'

    return 'white'

