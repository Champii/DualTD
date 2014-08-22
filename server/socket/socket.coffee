_ = require 'underscore'
socket = require 'socket.io'

bus = require '../bus'

sockets = []

exports.init = (server) ->
  io = socket.listen server, log: false

  io.sockets.on 'connection', (socket) ->

    socket.once 'playerId', (playerId) ->
      sockets[playerId] = socket
      socket.join 'player-' + playerId
      socket.join 'lobby'

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
    io.sockets.in('room-', roomId).emit type, message, arg1, arg2

  bus.on 'playerEnterLobby', (player) ->
    emitLobby 'playerEnterLobby', player

  bus.on 'playerLeaveLobby', (player) ->
    emitLobby 'playerLeaveLobby', player

