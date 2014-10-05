

StartGame = (socket) ->

  document.oncontextmenu = -> false

  game = new Game socket
