
StartGame = (socket) ->

  stage = new Kinetic.Stage
    container: 'game'
    width: document.body.scrollWidth
    height: document.body.scrollHeight
    draggable: true

  mainContainer = new Kinetic.Layer()
  stage.add mainContainer

  socket.on 'map', (map) ->
    console.log map
    for i in [0..map.size.x]
      for j in [0..map.size.y]
        floorShape = new Kinetic.Rect
          x: i * 20
          y: j * 20
          width: 20
          height: 20
          fill: GetTileColor map.tiles[i][j]
          stroke: 'black'
          lineWidth: 1
        mainContainer.add floorShape
    mainContainer.draw()


  GetTileColor = (tile) ->
    if tile is null
      return 'grey'
    else if tile.name is 'MainTower'
      return 'red'

    return 'white'