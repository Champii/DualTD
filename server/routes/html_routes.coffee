exports.mount = (app) ->

  app.get '*', (req, res) ->

    user = {}
    if req.user?
      user = req.user

    res.render 'index',
      user: user
