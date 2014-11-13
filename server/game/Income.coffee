class Income

  constructor: (@socket) ->
    @gold = 100
    @income = 10

    @timer = setInterval =>
      @gold += @income
      @socket.emit 'income', @gold
    , 10000

    @socket.emit 'income', @gold

  AddIncome: (amount) ->
    @income += amount

  DelIncome: (amount) ->
    @income -= amount

module.exports = Income
