class SpawnTower extends ATower

  constructor: (@container, @tower) ->
    @tower.color = 'green'

    @cMenu =
      noAction:
        name: 'No Action Yet'
        disabled: true

    super()
