class Crashdesk.Views.AppsForm extends Backbone.View
  className: 'modal hide fade'
  id: 'app_form'

  template: JST['apps/form']

  serialize: ->
    name        : this.$('#app_name').val()

  events:
    'submit form'  : 'createOrUpdateApp'

  initialize: ->
    $('#app_form').remove()
    @model.on('change:errors', @render, this)

  render: ->
    $(@el).html(@template(app: @model))
    $(@el).modal()
    this

  createOrUpdateApp: (event) ->
    event.preventDefault()
    if @model.isNew()
      @createApp()
    else
      @updateApp()

  createApp: ->
    event.preventDefault()
    @collection.create @serialize(),
      wait: true
      success: @handleSuccess
      error: @handleError

  updateApp: ->
    event.preventDefault()
    @model.save @serialize(),
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: (model) =>
    $(@el).modal('hide')
    Backbone.history.navigate("#{model.id}/errors", true)

  handleError: (model, response) =>
    if response.status == 422
      @model.set("errors", $.parseJSON(response.responseText).errors)
