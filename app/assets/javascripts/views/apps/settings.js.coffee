class Crashdesk.Views.AppsSettings extends Backbone.View
  id        : 'app-settings'
  className : 'modal hide fade'

  template: JST['apps/settings']

  events:
    'click .app-delete': 'destroy'

  initialize: ->
    #@model.on('reset', @render, this)
    @code = new Crashdesk.Views.AppsCode
      model: @model

  render: ->
    $(@el).html @template
      app: @model
    this.$('.modal-body').prepend(@code.render().el)
    $(@el).modal()
    this

  destroy: (e) ->
    e.preventDefault()
    @model.destroy()
    @$el.modal('hide')
    @$el.remove()
    Backbone.history.navigate("/", true)
