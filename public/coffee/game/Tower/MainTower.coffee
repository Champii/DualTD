class MainTower extends ATower

  constructor: (@mainContainer, tower) ->
    super tower

    towerShape = new Kinetic.Rect
      x: tower.position.x * 20
      y: tower.position.y * 20
      width: 20
      height: 20
      fill: 'red'
      stroke: 'black'
      lineWidth: 1

    towerShape.on 'mousedown', (e) =>
      if e.button == 2
        e.cancelBubble = true
        console.log @
        @ShowContextMenu()

    @mainContainer.add towerShape

    @menu =
      levelup:
        name: "LevelUp"
        callback: (key, options) ->
          #FIXME: send REST request
