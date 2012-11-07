class Crashdesk.Views.ErrorsList extends Backbone.View
  id        : 'errors'

  template: JST['shared/nothing']

  initialize: ->
    @app = @options.app
    @collection.on 'add', @appendErrorToList, this
    @collection.on 'reset', @selectFirst, this

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  selectFirst: ->
    if @collection.first()
      @collection.select(@collection.first())
    else
      $('#error').html JST['apps/code']
        app: @app
      $('#endless_list').append JST['errors/no_error_message']()

  appendErrorToList: (error, collection, options) =>
    # TODO event 'add' is called twice. Do deeply research
    # why
    #console.log error.get 'id'
    error = new Crashdesk.Views.ShortError({ model: error, collection: @collection })
    $(@el).append(error.render().el)
