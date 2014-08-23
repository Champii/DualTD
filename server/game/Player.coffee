class Player

  constructor: (player) ->
    @id = player.id
    @login = player.login
    @socket = player.socket
    @gold = 20

  Send: (type, message, arg1, arg2) ->
    @socket.emit type, message, arg1, arg2

module.exports = Player
