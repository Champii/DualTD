_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator'

PlayerResource = require './PlayerResource'

count = 0
class RoomRoute extends Modulator.Route.DefaultRoute
  Config: ->
    super()

    @Add 'post', '/:id/start', (req, res) ->
      req.room._ready = 0 if not req.room._ready?
      req.room._ready++
      req.room.Save ->
        console.log 'room start'
        if req.room._ready == 2
          bus.emit 'startGame', req.room

        res.status(200).end()

class RoomResource extends Modulator.Resource 'room', RoomRoute, {restrict: 'auth'}

  constructor: (blob, @players) ->
    super blob

  @Deserialize: (blob, done) ->
    async.map JSON.parse(blob.playersId), (item, done) =>
      PlayerResource.Fetch item, done
    , (err, players) ->
      return done err if err?

      done null, new RoomResource blob, players

RoomResource.Init()

module.exports = RoomResource
