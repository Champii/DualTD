dualtd.service 'userService', [
  '$http'
  '$window'
  ($http, $window) ->

    @current = null

    if __user.id?
      @current = __user

    console.log 'Current = ', @current

    @logout = ->
      $http.post('/api/1/players/logout')
        .success (data) ->
          $window.location.href = '/'

    @
]