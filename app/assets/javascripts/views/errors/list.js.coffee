class Crashdesk.Views.ErrorsList extends Backbone.View
  id        : 'errors'
  tagName   : 'section'
  className : 'span3'

  template: JST['shared/nothing']

  render: ->
    $(@el).html(@template())
    @collection.each(@appendErrorToList)
    this

  appendErrorToList: (error) =>
    error = new Crashdesk.Views.ShortError({ model: error, collection: @collection })
    $(@el).append(error.render().el)
