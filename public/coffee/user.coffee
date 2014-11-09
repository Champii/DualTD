dualtd.service 'userService', [
  '$http'
  '$window'
  'socket'
  ($http, $window, socket) ->

    @current = null

    if __user.id?
      @current = __user

    socket.on 'playerId', =>
      if @current? and @current.id
        console.log 'PlayerId', @current
        socket.emit 'playerId', @current.id

    @logout = ->
      $http.post('/api/1/players/logout')
        .success (data) ->
          $window.location.href = '/'

    @
]
