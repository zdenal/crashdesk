class Crashdesk.Views.ErrorsList extends Backbone.View
  id        : 'errors'

  template: JST['shared/nothing']

  initialize: ->
    @collection.on 'add', @render, this

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  appendErrorToList: (error) =>
    error = new Crashdesk.Views.ShortError({ model: error, collection: @collection })
    $(@el).append(error.render().el)
