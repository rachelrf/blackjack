class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<div style="background-image: url(cards/<%= rankName %>-<%= suitName %>.png);height:168px; width:auto;background-size: 100% 100%;"></div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

