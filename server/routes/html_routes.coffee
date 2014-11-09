bus = require '../bus'


id = 1
exports.mount = (app) ->

  app.get '/favicon.ico', (req, res) ->
    res.status(200).end()

  app.get '*', (req, res) ->

    req.userId = id++ if not req.userId?

    res.render 'index',
      user: {id: req.userId}


    # user = {}
    # if req.user?
    #   user = req.user

    # res.render 'index',
    #   user: user

