class Crashdesk.Views.ErrorDetail extends Backbone.View

  template: JST['errors/detail']

  render: ->
    $(@el).html(@template(error: @model))
    @appendCustomerList()
    this

  appendCustomerList: ->
    list = new Crashdesk.Views.CustomerList(model: @model)
    $("##{list.id}").remove()
    $('#error').after(list.render().el)
