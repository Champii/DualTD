_ = require 'underscore'
async = require 'async'

bus = require '../bus'

Modulator = require '../../Modulator'

PlayerResource = require './PlayerResource'

class TowerRoute extends Modulator.Route.DefaultRoute
  Config: ->
    super()

    @Add 'post', (req, res) ->
      req.body.roomId = parseInt req.body.roomId
      req.body.userId = parseInt req.body.userId

      async.auto
        player:                 (done)          -> PlayerResource.Fetch req.body.userId, done
        tryBuy:     ['player',  (done, results) -> results.player.TryBuy req.body, done]
        # tower:      ['tryBuy',  (done, results) => @resource.Deserialize req.body, done]
        # towerSaved: ['tower',   (done, results) -> results.tower.Save done]
      , (err, results) ->
        return res.status(500).send err if err?

        bus.emit 'newTower', req.body
        res.status(200).send req.body

class TowerResource extends Modulator.Resource 'tower', {abstract: true}
  Save: (done) ->
    isNew = not @id?

    super (err, instance) =>
      return done err if err?

      if isNew
        bus.emit 'sendToAll', 'newTower', @ToJSON()

      done null, instance

TowerResource.Init()

module.exports = TowerResource
module.exports.TowerRoute = TowerRoute
