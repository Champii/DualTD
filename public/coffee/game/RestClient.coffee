# Wrapper for $.ajax

class RestClient

  @Get: (url, done) ->
    $.ajax
      url: url
      type: 'GET'
      success: done

  @Post: (url, params, done) ->
    $.ajax
      url: url
      type: 'POST'
      data: params
      success: done
  @Put: (url, params, done) ->
    $.ajax
      url: url
      type: 'PUT'
      data: params
      success: done
  @Delete: (url, params, done) ->
    $.ajax
      url: url
      type: 'DELETE'
      data: params
      success: done

