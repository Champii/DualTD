_ = require 'underscore'
async = require 'async'

Modulator = require '../../Modulator/Modulator'

ALobby = Modulator.Resource 'lobby',
  empty: true
  restrict: 'auth'

PlayerResource = require './PlayerResource'

players = []

class LobbyResource extends ALobby

LobbyResource.Route 'get', '', (req, res) ->
  async.map players, PlayerResource.Fetch, (err, players) ->
    return res.send 500 if err?

    res.send 200, _(players).invoke 'ToJSON'

ALobby.ExtendedBy LobbyResource

module.exports = LobbyResource
