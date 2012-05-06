class Crashdesk.Views.ErrorDetail extends Backbone.View

  template: JST['errors/error_detail']

  initialize: ->
    @customers = @model.get('customers')

  render: ->
    $(@el).html(@template(error: @model))
    $('#customers').html('')
    _.each @customers, (customer) =>
      @appendCustomer new Crashdesk.Models.Customer customer
    this

  appendCustomer: (customer) ->
    customer = new Crashdesk.Views.CustomerDetail(model: customer)
    $('#customers').append(customer.render().el)
