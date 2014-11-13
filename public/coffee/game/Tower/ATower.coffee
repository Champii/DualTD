class ATower

  constructor: ->
    @name = @tower.name
    @life = @tower.life

    console.log __user

    @tower.color = 'black' if __user.id isnt @tower.userId

    towerShape = new Kinetic.Rect
      x: @tower.pos.x * 20
      y: @tower.pos.y * 20
      width: 20
      height: 20
      fill: @tower.color
      stroke: 'black'
      lineWidth: 1

    towerShape.on 'mousedown', (e) =>
      if e.evt.button is 2
        e.evt.cancelBubble = true
        contextMenu.Show @cMenu, e.evt

    @container.add towerShape

    @container.draw()

  ShowContextMenu: ->
    contextMenu.Show @menu

  HideContextMenu: ->
    contextMenu.Hide()
