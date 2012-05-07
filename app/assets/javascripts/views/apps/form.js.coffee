class Crashdesk.Views.AppsForm extends Backbone.View
  className: 'modal hide fade'
  id: 'app_form'

  template: JST['apps/form']

  serialize: ->
    name        : this.$('#app_name').val()
    app_type_id : this.$('#app_app_type_id').val()

  events:
    'submit form'  : 'createOrUpdateApp'

  initialize: ->
    $('#app_form').remove()
    @model.on('error', @render, this)

  render: ->
    $(@el).html(@template(app: @model, errors: @errors))
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
      success: => $(@el).modal('hide')
      error: @handleError

  updateApp: ->
    event.preventDefault()
    @model.save @serialize(),
      wait: true
      success: => $(@el).modal('hide')
      error: @handleError

  handleError: (model, response) =>
    if response.status == 422
      @errors = $.parseJSON(response.responseText).errors
      @model.trigger('error')
