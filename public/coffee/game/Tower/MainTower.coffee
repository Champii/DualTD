class MainTower extends ATower

  constructor: (@container, @tower) ->
    @tower.color = 'red'
    super()

    @cMenu =
      noAction:
        name: 'No Action Yet'
        disabled: true
      # levelup:
      #   name: "LevelUp"
      #   callback: (key, options) ->
      #     #FIXME: send REST request
