AliveObject = require '../AliveObject'

class ATower extends AliveObject

  constructor: (life) ->
    @userId = @player.id
    super life

  ToJSON: ->
    res = {}
    for k, v of @ when k isnt 'socket' and typeof v isnt 'function' and not v.id?
      res[k] = v
    res

module.exports = ATower
