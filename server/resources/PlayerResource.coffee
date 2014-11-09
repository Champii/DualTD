bus = require '../bus'

Modulator = require '../../Modulator/lib/Modulator'

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

class PlayerResource extends Modulator.Resource 'player', Modulator.Route.DefaultRoute, config

PlayerResource.Init()

module.exports = PlayerResource
