dualtd.factory 'socket', ['$rootScope', ($rootScope) ->
  socket = io.connect
    reconnection: false


  return {
    on: (eventName, callback) ->
      wrapper = () ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args

      socket.on eventName, wrapper

      return ->
        socket.removeListener eventName, wrapper

    emit: (eventName, data, callback) ->
      socket.emit eventName, data, ->
        args = arguments
        $rootScope.$apply ->
          if callback
            callback.apply socket, args

    socket: socket
  }
]
