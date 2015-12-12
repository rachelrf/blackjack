class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<div style=background-image: url("card-back.png")></div>'
  # template: _.template '<div style="background-image: url("cards/<%=rankName%>-<%=suitName%>.png")></div>'
  # template: _.template '<div style=background-image: url("img/cards/<%= rankName %>-<%= suitName %>.png")></div>'
  # template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png"'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

