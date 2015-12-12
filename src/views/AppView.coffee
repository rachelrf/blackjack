class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @el.childNodes[0].disabled = true
      @el.childNodes[2].disabled = true
      @model.get('playerHand').stand()
    'click button': -> @disableButtons()

  initialize: ->
    @render()
    if @model.get('playerHand').scores()[0] == 21 then @model.get('playerHand').stand()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    console.dir(@)

  disableButtons: ->
    if @model.get('playerHand').scores()[0] >= 21
      console.dir(@)
      @el.childNodes[0].disabled = true
      @el.childNodes[2].disabled = true

