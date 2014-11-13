class Bank

  constructor: (@owner) ->
    @socket = @owner.socket
    @owner.gold = @owner.gold || 100
    @owner.income = @owner.income || 10

    @timer = setInterval =>
      @owner.gold += @owner.income
      @owner.Save ->
      @Send()
    , 10000

    @owner.Save ->
    @Send()

  Buy: (obj, done) ->
    if obj.price > @owner.gold
      return done {err: 'Not enought money'}

    @owner.gold -= obj.price
    @owner.income += obj.income
    @owner.Save (err) =>
      return done err if err?

      @Send()
      done()

  Sell: (obj) ->
    @owner.gold += obj.price / 1.5
    @owner.income -= obj.income
    @owner.Save ->
    @Send()

  Send: ->
    @socket.emit 'income',
      gold: @owner.gold
      income: @owner.income

module.exports = Bank
