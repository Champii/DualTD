_ = require 'underscore'
async = require 'async'

Modulator = require '../../Modulator/Modulator'

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

ARoom.ExtendedBy RoomResource

module.exports = RoomResource
