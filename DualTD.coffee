_ = require 'underscore'
async = require 'async'
fs = require 'fs'
path = require 'path'
coffeeMiddleware = require 'coffee-middleware'
Modulator = require './Modulator/lib/Modulator'

Resources = require './server/resources'
Routes = require './server/routes'
Socket = require './server/socket/socket'

app = Modulator.app

MakeAssetsList = ->
  assets = {}

  assetsCoffee = require './settings/assets.json'
  assetsLib = require './settings/assets-lib.json'
  assetsCss = require './settings/assets-css.json'

  assets['/js/dualtd.min.js'] = assetsLib.concat assetsCoffee
  assets['/css/dualtd.min.css'] = assetsCss
  assets

dualRoot = path.resolve __dirname, '.'

app.use coffeeMiddleware
  src: path.resolve dualRoot, 'public'
  # compress: true
  prefix: 'js'
  bare: true
  force: true

app.use require('connect-cachify').setup MakeAssetsList(),
  root: path.join dualRoot, 'public'
  production: false

app.use Modulator.express.static path.resolve dualRoot, 'public'

app.set 'views', path.resolve dualRoot, 'public/views'
app.engine '.jade', require('jade').__express
app.set 'view engine', 'jade'

Resources.mount()

Routes.mount app

Socket.init Modulator.server

### TEMP INIT ###
PlayerResource = require './server/resources/PlayerResource'
RoomResource = require './server/resources/RoomResource'

toSave =
  login: 'a'
  password: 'a'

PlayerResource.Deserialize toSave, (err, player) ->
  return console.error err if err?

  player.Save (err) ->
    return console.error 'save', err if err?

    toSave =
      login: 'b'
      password: 'b'

    PlayerResource.Deserialize toSave, (err, player) ->
      return console.error err if err?

      player.Save (err) ->
        return console.error err if err?

        RoomResource.Deserialize
          playersId: JSON.stringify [1, 2]
        , (err, room) ->
          return console.error err if err?

          room.Save (err) ->
            return console.error err if err?

