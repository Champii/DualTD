_ = require 'underscore'
socket = require 'socket.io'

bus = require '../bus'
game = require '../game/main'

RoomResource = require '../resources/RoomResource'

sockets = []
exports.init = (server) ->
  io = socket.listen server, log: false

  io.sockets.on 'connection', (socket) ->

    socket.once 'playerId', (playerId) ->
      sockets[playerId - 1] = socket
      socket.join 'player-' + playerId

      if sockets.length is 2
        RoomResource.Fetch 1, (err, room) ->
          return console.error err if err?
          bus.emit 'playersEnterRoom', room, room.players

      # socket.join 'lobby'

    socket.emit 'playerId'

    socket.once 'disconnect', () ->
      sockets = _(sockets).reject (item) -> item is socket

  addToRoom = (room, socket) ->
    socket.join 'room-' + room.id
    socket.leave 'lobby'

  emitPlayer = (playerId, type, message, arg1, arg2) ->
    io.sockets.in('player-' + playerId).emit type, message, arg1, arg2

  emitLobby = (type, message, arg1, arg2) ->
    io.sockets.in('lobby').emit type, message, arg1, arg2

  emitRoom = (roomId, type, message, arg1, arg2) ->
    io.sockets.in('room-' + roomId).emit type, message, arg1, arg2

  bus.on 'playerEnterLobby', (player) ->
    emitLobby 'playerEnterLobby', player

  bus.on 'playerLeaveLobby', (player) ->
    emitLobby 'playerLeaveLobby', player

  bus.on 'playersEnterRoom', (room, players) ->
    console.log 'EnterRoom', room, players
    addToRoom room, sockets[players[0].id - 1]
    addToRoom room, sockets[players[1].id - 1]
    # emitRoom room.id, 'playersEnterRoom', room, players

  bus.on 'startGame', (room) ->
    emitRoom room.id, 'startGame'
    room.players[0].socket = sockets[room.players[0].id - 1]
    room.players[1].socket = sockets[room.players[1].id - 1]
    game room


  ### Game specific ###


