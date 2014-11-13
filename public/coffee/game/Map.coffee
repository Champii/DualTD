class Map

  constructor: (@mainContainer, @socket) ->
    @tileSize = 20
    @units = []

    @cMenu =
      towers:
        name: "Towers ->"
        items:
          spawnTower:
            name: "Spawn Tower"
            callback: (key, opt) =>
              # @map.tiles
              RestClient.Post '/api/1/spawnTowers',
                name: key
                pos: opt.pos
                roomId: roomId
                userId: __user.id
              , (data) ->


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
              if e.evt.button == 2
                e.evt.cancelBubble = true
                contextMenu.Show @cMenu, @GetPosFromMouse e.target.attrs

            @mainContainer.add floorShape

      @mainContainer.draw()

    @socket.on 'newTower', (tower) =>
      toBuild = null
      switch tower.name
        when 'spawnTower' then toBuild = SpawnTower
        when 'mainTower' then toBuild = MainTower

      @map.tiles[tower.pos.x][tower.pos.y] = new toBuild @mainContainer, tower

    @socket.on 'newUnit', (unit) =>
      console.log 'newUnit', unit
      @units[unit.id] = new Unit @mainContainer, @socket, unit


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
