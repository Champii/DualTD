_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Player = require './Player'
Map = require './Map'

class Game

  constructor: (room) ->
    @players = [
      new Player room.players[0]
      new Player room.players[1]
    ]

    bus.on 'sendToAll', (type, message, arg1, arg2) =>
      _(@players).each (player) -> player.Send type, message, arg1, arg2

    @map = new Map @players


module.exports = Game
