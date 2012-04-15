class Crashdesk.Views.AppRow extends Backbone.View
  tagName: 'tr'

  template: JST['apps/app_row']

  events:
    'click .destroy': 'destroy'
    'click .edit': 'edit'

  initialize: ->
    @model.on('destroy', @remove, this)
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(app: @model))
    this

  destroy: (event) ->
    event.preventDefault()
    @model.destroy()

  edit: (event) ->
    event.preventDefault()
    form = @collection.get_form @model
    $(@el).parent('table').after(form.render().el)
    $(form.el).modal()
