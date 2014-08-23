class ContextMenu

  constructor: ->

  Show: ->

    callback = (key, options) =>
      @Hide()

    $.contextMenu
      selector: '#game'
      events:
        show: =>
          stage.setDraggable false
        hide: =>
          stage.setDraggable true
      items:
        "actions":
          "name": "<p>Actions Menu</p>"
          "disabled": true
        "separator": "--------"
        "buildings":
          "name": "Buildings ->"
          "items":
            "offices":
              "name": "Offices ->"
              "items":
                "architectOffice":
                  "name": @ColorizePrice attachedObject, 'architectOffice', 'Architect Office'
                  "disabled": !city.buildingManager.CanBuy 'architectOffice', 1
                  "callback": callback
                "laboratory":
                  "name": @ColorizePrice attachedObject, 'laboratory', 'Laboratory'
                  "disabled": !city.buildingManager.CanBuy 'laboratory', 1
                  "callback": callback
            "mines":
              "name": "Mines ->"
              "items":
                "solarMine":
                  "name": @ColorizePrice attachedObject, 'solarMine', 'Solar Mine'
                  "disabled": !city.buildingManager.CanBuy 'solarMine', 1
                  "callback": callback
                "ironMine":
                  "name": @ColorizePrice attachedObject, 'ironMine', 'Iron Mine'
                  "disabled": !city.buildingManager.CanBuy 'ironMine', 1
                  "callback": callback
                "goldMine":
                  "name": @ColorizePrice attachedObject, 'goldMine', 'Gold Mine'
                  "disabled": !city.buildingManager.CanBuy 'goldMine', 1
                  "callback": callback
                "cristalMine":
                  "name": @ColorizePrice attachedObject, 'cristalMine', 'Cristal Mine'
                  "disabled": !city.buildingManager.CanBuy 'cristalMine', 1
                  "callback": callback
                "uraniumMine":
                  "name": @ColorizePrice attachedObject, 'uraniumMine', 'Uranium Mine'
                  "disabled": !city.buildingManager.CanBuy 'uraniumMine', 1
                  "callback": callback
                "petrolMine":
                  "name": @ColorizePrice attachedObject, 'petrolMine', 'Petrol Mine'
                  "disabled": !city.buildingManager.CanBuy 'petrolMine', 1
                  "callback": callback
        "tower":
          "name": "Tower ->"
          "items":
            "baseTower":
              "name": @ColorizePrice attachedObject, 'baseTower', 'Base Tower'
              "disabled": !city.buildingManager.CanBuy 'baseTower', 1
              "callback": callback

  Hide: ->
    $.contextMenu( 'destroy' )