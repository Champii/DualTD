_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Bank = require './Bank'
# Player = require './Player'
PlayerResource = require '../resources/PlayerResource'
Map = require './Map'

class Game

  constructor: (room) ->
    async.auto
      one:  (done) -> PlayerResource.Fetch 1, done
      oneSave: ['one', (done, results) ->
        results.one.socket = room.players[0].socket
        results.one.bank = new Bank results.one
        results.one.Save done]

      two:  (done) -> PlayerResource.Fetch 2, done
      twoSave: ['two', (done, results) ->
        results.two.socket = room.players[1].socket
        results.two.bank = new Bank results.two
        results.two.Save done]
    , (err, results) =>
      return console.error 'Error', err if err?

      @players = [
        results.oneSave
        results.twoSave
      ]

      bus.on 'sendToAll', () =>
        args = arguments
        args = Array.prototype.slice.call args, arguments
        _(@players).each (player) ->
          player.Send.apply player, args

      @map = new Map @players



module.exports = Game
