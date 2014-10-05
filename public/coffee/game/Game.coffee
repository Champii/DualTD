class Game

  constructor: (@socket) ->
    @stage = new Kinetic.Stage
      container: 'game'
      width: document.body.scrollWidth
      height: document.body.scrollHeight
      draggable: true

    @mainContainer = new Kinetic.Layer()
    @stage.add @mainContainer

    @map = new Map @mainContainer, @socket
