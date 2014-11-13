class Map

  constructor: (@mainContainer, @socket) ->
    @tileSize = 20

    @cMenu =
      towers:
        name: "Towers ->"
        items:
          spawnTower:
            name: "Spawn Tower"
            # callback: (key, opt) -> contextMenu.CallBack key, opt
            callback: (key, opt) =>
            # done: (key, obj, c) =>
              # @map.tiles
              RestClient.Post '/api/1/towers',
                name: key
                pos: opt.pos
                roomId: roomId
                userId: __user.id
              , (data) ->
                console.log 'Got : ', data

              console.log 'base tower callback', key, opt

    @socket.on 'map', (@map) =>
      for i in [0..@map.size.x]
        for j in [0..@map.size.y]
          if @map.tiles[i][j] is null
            floorShape = new Kinetic.Rect
              x: i * @tileSize
              y: j * @tileSize
              width: @tileSize
              height: @tileSize
              fill: @GetTileColor @map.tiles[i][j]
              stroke: 'black'
              lineWidth: 1

            floorShape.on 'mousedown', (e) =>
              console.log @GetPosFromMouse e.target.attrs
              if e.evt.button == 2
                e.evt.cancelBubble = true
                console.log 'mousedown', e
                contextMenu.Show @cMenu, @GetPosFromMouse e.target.attrs

            @mainContainer.add floorShape

          else if @map.tiles[i][j].name is 'mainTower'
            @map.tiles[i][j] = new MainTower @mainContainer, @map.tiles[i][j]

      @mainContainer.draw()

    @socket.on 'newTower', (tower) =>
      tower.pos =
        x: parseInt tower.pos.x
        y: parseInt tower.pos.y

      switch tower.name
        when 'spawnTower'
          @map.tiles[tower.pos.x][tower.pos.y] = new SpawnTower @mainContainer, tower


  GetTileColor: (tile) ->
    if tile is null
      return 'grey'
    else if tile.name is 'MainTower'
      return 'red'

    return 'white'

  GetPosFromMouse: (pos) ->
    pos =
      x: Math.floor((pos.x - (pos.x % @tileSize)) / @tileSize)
      y: Math.floor((pos.y - (pos.y % @tileSize)) / @tileSize)
