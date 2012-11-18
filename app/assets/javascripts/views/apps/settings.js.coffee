class Crashdesk.Views.AppsSettings extends Backbone.View
  id        : 'app-settings'
  className : 'modal hide fade'

  template: JST['apps/settings']

  events:
    'click .app-delete': 'destroy'

  initialize: ->
    #@model.on('reset', @render, this)

  render: ->
    $(@el).html @template
      app: @model
    $(@el).modal()
    this

  destroy: (e) ->
    e.preventDefault()
    @model.destroy()
    @$el.modal('hide')
    @$el.remove()
    Backbone.history.navigate("/", true)
