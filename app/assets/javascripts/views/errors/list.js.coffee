class Crashdesk.Views.ErrorsList extends Backbone.View
  id        : 'errors'

  template: JST['shared/nothing']

  initialize: ->
    @collection.on 'add', @appendErrorToList, this
    @collection.on 'reset', @selectFirst, this

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  selectFirst: ->
    @collection.select(@collection.first()) if @collection.first()

  appendErrorToList: (error, collection, options) =>
    # TODO event 'add' is called twice. Do deeply research
    # why
    #console.log error.get 'id'
    error = new Crashdesk.Views.ShortError({ model: error, collection: @collection })
    $(@el).append(error.render().el)
