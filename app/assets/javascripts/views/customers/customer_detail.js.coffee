class Crashdesk.Views.CustomerDetail extends Backbone.View

  template: JST['customers/customer_detail']

  render: ->
    $(@el).html(@template(customer: @model))
    this

