class Income

  constructor: (@socket) ->
    @socket.on 'income', (@gold) =>
