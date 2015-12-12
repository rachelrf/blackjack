class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="double-button">Double down</button> <button class="split-button">Split</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.get('playerHand').hit()
      @el.childNodes[4].disabled = true
    'click .stand-button': -> 
      @disableButtons()
      @model.get('playerHand').stand()
    'click .double-button': ->
      @disableButtons()
      @model.get('playerHand').doubleDown()
    'click button': ->
      if @model.get('playerHand').scores()[0] >= 21 then @disableButtons()
    'click .split-button': ->
      @model.get('playerHand').split()
      @splitRender()

  splitRender: ->
     #@$('.player-hand-container').append new HandView(collection: @model.get 'splitHand').el
     console.log('got to splitrender in app view')
     @render()

  initialize: ->
    @render()
    hand = @model.get('playerHand').models
    if hand[0].get('value') == hand[1].get('value')
      @el.childNodes[6].disabled = false
    else 
      @el.childNodes[6].disabled = true
    if @model.get('playerHand').scores()[0] == 21 then @model.get('playerHand').stand()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    if @model.get('splitHand')?
      console.log('tryna render')
      @$('.player-hand-container').append new HandView(collection: @model.get 'splitHand').el

  disableButtons: ->
    @el.childNodes[0].disabled = true
    @el.childNodes[2].disabled = true
    @el.childNodes[4].disabled = true
    @el.childNodes[6].disabled = true

