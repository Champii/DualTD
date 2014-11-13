Modulator = require '../../Modulator'

bus = require '../bus'

sockets = []
class SocketResource extends Modulator.Resource 'socket', {abstract: true}

  Save: (done) ->
    isNew = not @id?

    super (err, instance) =>
      return done err if err?

      if @socket? and not sockets[@id]?
        sockets[@id] = @socket
      else if @socket? and not sockets[@userId]?
        sockets[@userId] = @socket

      done null, instance

  @Deserialize: (blob, done) ->
    if blob.id? and sockets[blob.id]?
      blob.socket = sockets[blob.id]
    else if blob.userId? and sockets[blob.userId]?
      blob.socket = sockets[blob.userId]

    super blob, done

SocketResource.Init()

module.exports = SocketResource
