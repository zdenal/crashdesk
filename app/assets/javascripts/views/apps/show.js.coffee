class Crashdesk.Views.AppsShow extends Backbone.View
  id        : 'app'
  className : 'row-fluid'

  template: JST['apps/show']

  initialize: ->
    @apps = @options.apps
    @getErrors()
    @model.on('reset', @render, this)
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html @template
      apps: @apps
      app: @model
    error_list = new Crashdesk.Views.ErrorsList
      collection : @collection
    this.$('#endless_list #error_list').html(error_list.render().el)
    scroller = new EndlessScroller @collection,
      window     : this.$('#endless_list')
      list       : this.$('#endless_list #errors')
    this

  getErrors: ->
    @collection = new Crashdesk.Collections.Errors()
    @collection.fetch
      data:
        app_key: @model.id
