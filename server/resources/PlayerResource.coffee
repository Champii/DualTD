bus = require '../bus'

Modulator = require '../../Modulator/lib/Modulator'
Bank = require '../game/Bank'

prices = require '../game/prices'

SocketResource = require './SocketResource'

config =
  account:
    fields:
      usernameField: 'login',
      passwordField: 'password'
    loginCallback: (player, done) ->
      bus.emit 'playerEnterLobby', player
      done()
    logoutCallback: (player, done) ->
      bus.emit 'playerLeaveLobby', player
      done()
  restrict: 'user'

banks = []
class PlayerResource extends SocketResource.Extend 'player', Modulator.Route.DefaultRoute, config

  Save: (done) ->
    isNew = not @id?

    super (err, instance) =>
      return done err if err?

      if @bank? and not banks[@id]?
        banks[@id] = @bank

      done null, instance

  Send: ->
    args = arguments
    args = Array.prototype.slice.call args, arguments
    @socket.emit.apply @socket, args

  TryBuy: (tower, done)->
    @bank.Buy prices[tower.name], done

  @Deserialize: (blob, done) ->
    if blob.id? and banks[blob.id]?
      blob.bank = banks[blob.id]

    super blob, done


PlayerResource.Init()

module.exports = PlayerResource
