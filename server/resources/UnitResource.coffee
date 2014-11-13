Modulator = require '../../Modulator'

bus = require '../bus'

class UnitResource extends Modulator.Resource 'unit'

  constructor: (blob) ->
    super blob
    @life = 100 if not @life?
    @speed = 0.5 if not @speed?
    @name = 'unit' if not @name?

    @Start()

  Save: (done) ->
    super (err, instance) =>
      return done err if err?

      bus.emit 'sendToAll', 'unit' + @id, @Serialize()
      done null, instance

  _MakePath: ->


  _NextPos: ->
    console.log @mainTargetPos, @pos, @a, Math.abs @a
    pos =
      x: @pos.x + @speed
      y: @pos.y + (@a * @speed)

  _FindTarget: ->

  _Attack: ->

  Start: ->
    @a = (@mainTargetPos.y - @towerPos.y) / (@mainTargetPos.x - @towerPos.x)
    @_moveTimer = setInterval =>
      @pos = @_NextPos()
        # x: @pos.x + @speed
        # y: @pos.y + @speed
      @Save =>
        console.log 'posChange', @pos

    , 1000

  @Spawn: (blob) ->
    console.log blob
    # FIXME
    blob.pos =
      x: parseInt blob.pos.x
      y: parseInt blob.pos.y
    blob.mainTargetPos =
      x: parseInt blob.mainTargetPos.x
      y: parseInt blob.mainTargetPos.y

    @Deserialize blob, (err, unit) ->
      return console.error err if err?

      unit.Save (err) ->
        return console.error err if err?

        bus.emit 'sendToAll', 'newUnit', unit.ToJSON()


UnitResource.Init()

module.exports = UnitResource
