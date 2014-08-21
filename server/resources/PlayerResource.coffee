Modulator = require '../../Modulator/Modulator'

APlayer = Modulator.Resource 'player',
  account:
    fields:
      usernameField: 'login',
      passwordField: 'password'
  restrict: 'user'

class PlayerResource extends APlayer

APlayer.ExtendedBy PlayerResource

module.exports = PlayerResource
