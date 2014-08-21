_ = require 'underscore'
async = require 'async'
fs = require 'fs'
path = require 'path'
coffeeMiddleware = require 'coffee-middleware'

Modulator = require './Modulator/Modulator'

Resources = require './server/resources'
Routes = require './server/routes'

app = Modulator.app


MakeAssetsList = ->
  readDir = (folder) ->
    basePath = path.resolve(dualRoot, 'public/' + folder)
    paths = _(fs.readdirSync(basePath)).map (item) -> '/' + folder + '/' + item
    _(paths).map (item) ->
      splited = item.split '.'
      if splited[1] is 'coffee'
        splited[1] = 'js'
      splited.join '.'

  assets = {}

  assets['/js/dualtd.min.js'] = readDir('js')
                                      .concat readDir('coffee')

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
