class Crashdesk.Views.ErrorDetail extends Backbone.View

  template: JST['errors/detail']

  events:
    'click #tag_manager': 'tagManager'
    'click #person_manager': 'personManager'

  initialize: ->
    @model.on 'change', @render, this

  render: ->
    $(@el).html(@template(error: @model))
    this

  tagManager: (event) ->
    event.preventDefault()
    tag_manager = @model.get_tag_manager()
    $(@el).append(tag_manager.render().el)

  personManager: (event) ->
    event.preventDefault()
    person_manager = @model.get_person_manager()
    $(@el).append(person_manager.render().el)
