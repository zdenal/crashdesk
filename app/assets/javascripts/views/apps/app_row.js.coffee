class Crashdesk.Views.AppRow extends Backbone.View
  tagName: 'tr'

  template: JST['apps/app_row']

  events:
    'click .destroy': 'destroy'
    'click .edit': 'edit'
    'click .show': 'show'

  initialize: ->
    @model.on('destroy', @remove, this)
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(app: @model))
    this

  show: (event) ->
    event.preventDefault()
    Backbone.history.navigate "apps/#{@model.get('_id')}", true

  destroy: (event) ->
    event.preventDefault()
    @model.destroy()

  edit: (event) ->
    event.preventDefault()
    form = @collection.get_form @model
    $(@el).parent('table').after(form.render().el)
