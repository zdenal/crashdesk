class Crashdesk.Views.ShortError extends Backbone.View
  className : 'error-preview'
  tagName   : 'article'

  template: JST['errors/short_error']

  events:
      'click': 'showErrorDetail'

  render: ->
    $(@el).html(@template(error: @model))
    this

  showErrorDetail: (e) ->
    e.preventDefault()
    error_detail = new Crashdesk.Views.ErrorDetail model: @model
    $('#error').html(error_detail.render().el)
    @showCustomers()
    console.log @model
    console.log @options.app.get('name')

  showCustomers: ->
    list = new Crashdesk.Views.CustomerList(model: @model)
    $("##{list.id}").remove()
    $('#error').after(list.render().el)