class Crashdesk.Views.AppRow extends Backbone.View
  tagName: 'tr'

  template: JST['apps/app_row']

  events:
    'click .destroy': 'destroy'
    'click .edit': 'edit'
    'click .show': 'show'
    'click .code': 'code'

  initialize: ->
    @model.on('destroy', @remove, this)
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(app: @model))
    this

  show: (event) ->
    event.preventDefault()
    Backbone.history.navigate "#{@model.id}/errors", true

  destroy: (event) ->
    event.preventDefault()
    conf = new Confirm()
    conf.notify().on 'click:yes', =>
      @model.destroy
        wait: true
        success: ->
          conf.destroyAll()

  edit: (event) ->
    event.preventDefault()
    form = @collection.get_form @model
    $(@el).parent('table').after(form.render().el)

  code: (event) ->
    event.preventDefault()
    code = @model.get_code @model
    $(@el).parent('table').after(code.render().el)
