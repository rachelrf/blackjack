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
            if playerScore <= 21 then displayResult '1You win!' else displayResult '2You lose!'
          if dealerScore == 21
            if playerScore == 21 then displayResult '3Tie!' else displayResult '4You lose!'
          if dealerScore < 21
            if dealerScore < playerScore && playerScore <= 21 then displayResult '5You win!' else displayResult '6You lose!'

        if dealerScore < 17
          dealerHand.hit()
          dealerScore = dealerHand.scores()[0]
          setTimeout (-> dealerPlay(dealerScore, playerScore)), 1000 


    @listenTo playerHand,'stand', => 
      dealerHand.models[0].flip()
      playerScore = playerHand.scores()[0]
      dealerScore = dealerHand.scores()[0]
      setTimeout (-> dealerPlay(dealerScore, playerScore)), 1000 

    @listenTo playerHand, 'hit', =>
      playerScore = playerHand.scores()[0]
      if playerScore >= 21 then playerHand.trigger("stand")

