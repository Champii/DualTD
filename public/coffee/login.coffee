dualtd.directive 'dtdLogin', [
  '$http'
  '$window'
  'userService'
  ($http, $window, userService) ->
    return {

      restrict: 'E'

      replace: true

      templateUrl: 'login-tpl'

      link: (scope, elem, attr) ->

        scope.cred =
          login: ''
          password: ''
          password2: ''
          email: ''

        scope.userService = userService

        scope.signup = false

        scope.toggleSignup = ->
          scope.signup = !scope.signup

        scope.login = ->
          $http.post('/api/1/players/login', scope.cred)
            .success ->
              $window.location.href = '/'
            .error (data) ->
              scope.message = 'Error login: ' + data
              setTimeout ->
                scope.$apply ->
                  scope.message = ''
              , 3000

        scope.doSignup = ->
          $http.post('/api/1/players', scope.cred)
            .success ->
              scope.toggleSignup()
              scope.message = 'You can now login'
            .error (data) ->
              scope.message = 'Error signup: ' + data

    }
]