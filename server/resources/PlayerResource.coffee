bus = require '../bus'

Modulator = require '../../Modulator/lib/Modulator'

APlayer = Modulator.Resource 'player',
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

class PlayerResource extends APlayer

APlayer.ExtendedBy PlayerResource

module.exports = PlayerResource
