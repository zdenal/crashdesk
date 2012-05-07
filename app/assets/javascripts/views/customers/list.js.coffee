class Crashdesk.Views.CustomerList extends Backbone.View
  className : 'span2'
  id        : 'customers'
  tagName   : 'section'

  template: JST['customers/list']

  initialize: ->
    @customers = @model.get('customers')

  render: ->
    $(@el).html(@template(customer: @model))
    _.each @customers, (customer) =>
      @appendCustomer new Crashdesk.Models.Customer customer
    this

  appendCustomer: (customer) =>
    customer_detail = new Crashdesk.Views.CustomerDetail(model: customer)
    this.$('.accordion').append(customer_detail.render().el)
