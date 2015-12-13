# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'splitHand', null

    playerHand = @get 'playerHand' 
    dealerHand = @get 'dealerHand'
    splitHand = @get 'splitHand'
    alreadySplit = false;

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
            if dealerScore < playerScore && playerScore <= 21 then displayResult 'You win!' else displayResult 'You lose!'

        if dealerScore < 17
          dealerHand.hit()
          dealerScore = dealerHand.scores()[0]
          setTimeout (-> dealerPlay(dealerScore, playerScore)), 1000 


    @listenTo playerHand,'stand', => 
      console.log('entered stand, already split is', alreadySplit)
      if splitHand? && alreadySplit != true
        @set 'playerHand', splitHand
        playerHand = @get 'playerHand'
        alreadySplit = true

        @listenTo playerHand,'stand', =>
          dealerHand.models[0].flip()
          playerScore = playerHand.scores()[0]
          dealerScore = dealerHand.scores()[0]
          setTimeout (-> dealerPlay(dealerScore, playerScore)), 1000

        @listenTo playerHand, 'hit', =>
          console.log('hit listened to')
          playerScore = playerHand.scores()[0]
          if playerScore >= 21 then playerHand.trigger("stand")

        @listenTo playerHand, 'doubleDown', =>
          playerHand.trigger("stand")

        @listenTo playerHand, "split", =>
          @set 'splitHand', deck.dealPlayer()
          splitHand = @get 'splitHand' 
          temp = splitHand.models[0]
          splitHand.models[0] = playerHand.models[1]
          playerHand.models[1] = temp
          console.log('got to split in app model', @get 'splitHand')
          # @get('splitHand').trigger("splitRender")

      else 
        dealerHand.models[0].flip()
        playerScore = playerHand.scores()[0]
        dealerScore = dealerHand.scores()[0]
        setTimeout (-> dealerPlay(dealerScore, playerScore)), 1000 

    @listenTo playerHand, 'hit', =>
      console.log('hit listened to')
      playerScore = playerHand.scores()[0]
      if playerScore >= 21 then playerHand.trigger("stand")

    @listenTo playerHand, 'doubleDown', =>
      playerHand.trigger("stand")

    @listenTo playerHand, "split", =>
      @set 'splitHand', deck.dealPlayer()
      splitHand = @get 'splitHand' 
      temp = splitHand.models[0]
      splitHand.models[0] = playerHand.models[1]
      playerHand.models[1] = temp
      console.log('got to split in app model', @get 'splitHand')
      # @get('splitHand').trigger("splitRender")

