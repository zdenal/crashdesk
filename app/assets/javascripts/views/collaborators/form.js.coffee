class Crashdesk.Views.CollaboratorsForm extends Backbone.View
  className: 'modal hide fade'
  id: 'collaborator_form'

  template: JST['collaborators/form']

  serialize: ->
    email  : this.$('#collaborator_email').val()
    app_id : @app.id

  events:
    'submit form'  : 'addCollaborator'

  initialize: ->
    $('#collaborator_form').remove()
    @model.on('change:errors', @render, this)
    @app = @options.app

  render: ->
    $(@el).html @template
      collaborator: @model
      collaborators: @collection.models
    $(@el).modal()
    this

  addCollaborator: ->
    event.preventDefault()
    @collection.create @serialize(),
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: (model) =>
    $(@el).modal('hide')

  handleError: (model, response) =>
    if response.status == 422
      @model.set("errors", $.parseJSON(response.responseText).errors)
