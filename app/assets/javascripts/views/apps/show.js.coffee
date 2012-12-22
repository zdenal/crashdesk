class Crashdesk.Views.AppsShow extends Backbone.View
  id        : 'app'
  className : 'row-fluid'

  template: JST['apps/show']

  events:
    'click #settings': 'showSettings'
    'click #add': 'newApp'

  initialize: ->
    @apps = @options.apps
    @getErrors()
    @model.on('reset', @render, this)
    @collection.on('reset', @render, this)
    @settings = new Crashdesk.Views.AppsSettings
      model: @model
    @form = new Crashdesk.Views.AppsForm
      model: new Crashdesk.Models.App
      collection: @apps
    @error_list = new Crashdesk.Views.ErrorsList
      collection : @collection
      app        : @model

  render: ->
    $(@el).html @template
      apps: @apps
      app: @model
    this.$('#endless_list #error_list').html(@error_list.render().el)
    scroller = new EndlessScroller @collection,
      window     : this.$('#endless_list')
      list       : this.$('#endless_list #errors')
    this

  showSettings: (e) ->
    e.preventDefault()
    @settings.render().el

  newApp: (e) ->
    e.preventDefault()
    @form.render().el

  getErrors: ->
    @collection = new Crashdesk.Collections.Errors()
    @collection.fetch
      data:
        app_id: @model.id
