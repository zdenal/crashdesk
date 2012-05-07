class Crashdesk.Views.CustomerDetail extends Backbone.View

  template: JST['customers/detail']

  render: ->
    $(@el).html(@template(customer: @model))
    this

