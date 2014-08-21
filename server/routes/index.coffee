_ = require 'underscore'

routes = [
  'html']

exports.mount = (app) ->
  _(routes).each (route) ->
    require('./' + route + '_routes.coffee').mount(app)
