_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator/Modulator'

ALobby = Modulator.Resource 'lobby',
  empty: true
  restrict: 'auth'

PlayerResource = require './PlayerResource'

players = []

class LobbyResource extends ALobby

  @AddPlayer: (playerId) -> players.push playerId
  @DelPlayer: (playerId) -> players = _(players).reject (item) -> item is playerId

bus.on 'playerEnterLobby', (player) ->
  LobbyResource.AddPlayer player.id

bus.on 'playerLeaveLobby', (player) ->
  LobbyResource.DelPlayer player.id

LobbyResource.Route 'get', '', (req, res) ->
  async.map players, PlayerResource.Fetch, (err, players) ->
    return res.send 500 if err?

    res.send 200, _(players).invoke 'ToJSON'

ALobby.ExtendedBy LobbyResource

module.exports = LobbyResource
