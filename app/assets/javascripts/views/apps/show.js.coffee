class Crashdesk.Views.AppsShow extends Backbone.View
  id: 'app'

  template: JST['apps/show']

  initialize: ->
    @getErrors()
    @model.on('reset', @render, this)
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  appendErrorToList: (error) =>
    error = new Crashdesk.Views.ShortError({ model: error, app: @model })
    this.$('#errors').append(error.render().el)

  getErrors: ->
    @collection = new Crashdesk.Collections.Errors()
    @collection.fetch()
