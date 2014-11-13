_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator'

class TowerRoute extends Modulator.Route.DefaultRoute
  Config: ->
    super()

    @Add 'post', (req, res) ->
      req.body.roomId = parseInt req.body.roomId
      req.body.userId = parseInt req.body.userId

      TowerResource.Deserialize req.body, (err, tower) ->
        return res.status(500).send err if err?

        tower.Save (err) ->
          return res.status(500).send err if err?

          bus.emit 'newTower', tower
          res.status(200).send tower

class TowerResource extends Modulator.Resource 'tower', TowerRoute

TowerResource.Init()

module.exports = TowerResource
