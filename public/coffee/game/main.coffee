roomId = 0
game = null

StartGame = (room, socket) ->

  roomId = room

  document.oncontextmenu = -> false

  game = new Game socket
