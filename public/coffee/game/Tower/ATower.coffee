class ATower

  constructor: (tower) ->
    @name = tower.name
    @life = tower.life

  ShowContextMenu: ->
    contextMenu.Show @menu

  HideContextMenu: ->
    contextMenu.Hide()
