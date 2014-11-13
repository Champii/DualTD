class Bank

  constructor: (@socket) ->
    @socket.on 'income', (bank) =>
      @gold = bank.gold
      @income = bank.income
