class Crashdesk.Views.ErrorDetail extends Backbone.View

  template: JST['errors/detail']

  events:
    'click #tag_manager': 'tagManager'
    'click #person_manager': 'personManager'
    'click #next_error': 'nextError'
    'click #prev_error': 'prevError'
    'click #destroy': 'destroySelected'

  initialize: ->
    @model.on 'change', @render, this
    @model.on 'change:selected', @unbind, this

  render: ->
    $(@el).html @template
      error: @model
      has_next: @collection.hasNext()
      has_prev: @collection.hasPrev()
    @$('#deadline').datepicker().on 'hide', @updateDeadline
    this

  tagManager: (event) ->
    event.preventDefault()
    tag_manager = @model.get_tag_manager()
    $(@el).append(tag_manager.render().el)

  personManager: (event) ->
    event.preventDefault()
    person_manager = @model.get_person_manager()
    $(@el).append(person_manager.render().el)

  updateDeadline: (event) =>
    @model.set 'deadline', @$('#deadline input').val()

  nextError: (event) ->
    event.preventDefault()
    @collection.selectNext() if @collection.hasNext()
    @unbind()

  prevError: (event) ->
    event.preventDefault()
    @collection.selectPrev() if @collection.hasPrev()
    @unbind()

  destroySelected: (event) ->
    event.preventDefault()
    @collection.destroySelected()

  unbind: ->
    # seems it has better performance with this
    @model.off 'change', @render, this
    @remove()
