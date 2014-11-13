_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator/lib/Modulator'

PlayerResource = require './PlayerResource'
RoomResource = require './RoomResource'

players = []
waitingRoom = []

class LobbyRoute extends Modulator.Route.DefaultRoute
  Config: ->
    super()

    @Add 'get', (req, res) ->
      async.map players, PlayerResource.Fetch, (err, players) ->
        return res.status(500).end() if err?

        res.status(200).send _(players).invoke 'ToJSON'

    @Add 'post', '/random', (req, res) ->
      LobbyResource.SwitchToWaitingRoom req.user.id
      res.status(200).end()

class LobbyResource extends Modulator.Resource 'lobby', LobbyRoute, {restrict: 'auth'}

  @AddPlayer: (playerId) -> players.push playerId
  @DelPlayer: (playerId) -> players = _(players).reject (item) -> item is playerId

  @SwitchToWaitingRoom: (playerId) ->
    @DelPlayer playerId
    waitingRoom.push playerId
    if waitingRoom.length >= 2
      p1 = waitingRoom.pop()
      p2 = waitingRoom.pop()
      bus.emit 'playerLeaveLobby', id: p1
      bus.emit 'playerLeaveLobby', id: p2
      RoomResource.Deserialize
        playersId: JSON.stringify [p1, p2]
      , (err, room) ->
        return console.error err if err?

        room.Save (err) ->
          return console.error err if err?

          bus.emit 'playersEnterRoom', room.ToJSON(), room.players

bus.on 'playerEnterLobby', (player) ->
  LobbyResource.AddPlayer player.id

bus.on 'playerLeaveLobby', (player) ->
  LobbyResource.DelPlayer player.id

LobbyResource.Init()

module.exports = LobbyResource
