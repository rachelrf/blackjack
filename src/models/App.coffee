# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    playerHand = @get 'playerHand' 
    dealerHand = @get 'dealerHand'

    displayResult = (message) ->
      alert(message)
      window.location.reload()
    
    dealerPlay = (dealerScore, playerScore) -> 
      if dealerScore >= 17 
          if dealerScore > 21 
            if playerScore <= 21 then displayResult 'You win!' else displayResult 'You lose!'
          if dealerScore == 21
            if playerScore == 21 then displayResult 'Tie!' else displayResult 'You lose!'
          if dealerScore < 21
            if dealerScore > playerScore then displayResult 'You lose!' else displayResult 'You win!'

        if dealerScore < 17
          dealerHand.hit()
          dealerScore = dealerHand.scores()[0]
          dealerPlay(dealerScore, playerScore)


    @listenTo playerHand,'stand', => 
      dealerHand.models[0].flip()
      playerScore = playerHand.scores()[0]
      dealerScore = dealerHand.scores()[0]
      dealerPlay(dealerScore, playerScore)

    @listenTo playerHand, 'hit', =>
      playerScore = playerHand.scores()[0]
      if playerScore >= 21 then playerHand.trigger("stand")