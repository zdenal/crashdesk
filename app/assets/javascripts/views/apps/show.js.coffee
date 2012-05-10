class Crashdesk.Views.AppsShow extends Backbone.View
  id        : 'app'
  className : 'row-fluid'

  template: JST['apps/show']

  initialize: ->
    @getErrors()
    @model.on('reset', @render, this)
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    error_list = new Crashdesk.Views.ErrorsList(collection: @collection)
    this.$('#icons-bar').after(error_list.render().el)
    this

  getErrors: ->
    @collection = new Crashdesk.Collections.Errors()
    @collection.fetch()
