class Unit

  constructor: (@container, @socket, unit) ->

    @life = unit.life
    @name = unit.name
    @pos = unit.pos
    @id = unit.id
    @userId = unit.userId

    color = 'blue'
    color = 'black' if @userId isnt __user.id

    unitShape = new Kinetic.Circle
      x: unit.pos.x * 20
      y: unit.pos.y * 20
      radius: 5
      fill: color
      lineWidth: 1

    @container.add unitShape

    @container.draw()


    @socket.on 'unit' + @id, (unit) =>
      unit.pos =
        x: Math.floor unit.pos.x * 20
        y: Math.floor unit.pos.y * 20
      _(@).extend unit

      unitShape.setAttrs
        x: @pos.x
        y: @pos.y
      @container.draw()
