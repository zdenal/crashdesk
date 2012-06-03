class Crashdesk.Views.ErrorsList extends Backbone.View
  id        : 'errors'

  template: JST['shared/nothing']

  initialize: ->
    @collection.on 'add', @appendErrorToList, this

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  appendErrorToList: (error, collection, options) =>
    # TODO event 'add' is called twice. Do deeply research
    # why
    #console.log error.get 'id'
    error = new Crashdesk.Views.ShortError({ model: error, collection: @collection })
    $(@el).append(error.render().el)
