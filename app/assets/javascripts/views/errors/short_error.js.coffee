class Crashdesk.Views.ShortError extends Backbone.View
  className : 'error-preview clickable'
  tagName   : 'article'

  template: JST['errors/short_error']

  events:
      'click': 'showEvent'

  initialize: ->
    @model.on 'change', @render, this
    @model.on 'destroy', @remove, this
    @model.on 'change:selected', @changeSelected, this

  render: ->
    $(@el).html(@template(error: @model))
    this

  showEvent: (e) ->
    e.preventDefault()
    @collection.select(@model)

  showErrorDetail: ->
    error_detail = new Crashdesk.Views.ErrorDetail
      model: @model,
      collection: @collection
    $('#error').html(error_detail.render().el)
    @showCustomers()

  showCustomers: ->
    list = new Crashdesk.Views.CustomerList(model: @model)
    $("##{list.id}").remove()
    $('#error').after(list.render().el)

  changeSelected: ->
    if @model.is_selected()
      $(@el).addClass 'selected'
      @showErrorDetail()
    else
      $(@el).removeClass 'selected'
