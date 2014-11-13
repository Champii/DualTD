Income = require './Income'

class Player

  constructor: (player) ->
    @id = player.id
    @login = player.login
    @socket = player.socket
    @income = new Income @socket

  Send: () ->
    args = arguments
    args = Array.prototype.slice.call args, arguments
    @socket.emit.apply @socket, args

module.exports = Player
