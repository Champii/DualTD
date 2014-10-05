_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator/lib/Modulator'

PlayerResource = require './PlayerResource'

ARoom = Modulator.Resource 'room',
  restrict: 'auth'

class RoomResource extends ARoom

  constructor: (blob, @players) ->
    super blob

  @Deserialize: (blob, done) ->
    async.map JSON.parse(blob.playersId), PlayerResource.Fetch, (err, players) ->
      return done err if err?

      done null, new RoomResource blob, players

RoomResource.Route 'post', '/:id/start', (req, res) ->
  req.room._ready = 0 if not req.room._ready?
  req.room._ready++
  req.room.Save ->

    if req.room._ready == 2
      bus.emit 'startGame', req.room

    res.status(200).end()

ARoom.ExtendedBy RoomResource

module.exports = RoomResource
