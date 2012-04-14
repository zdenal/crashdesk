class Crashdesk.Views.AppsIndex extends Backbone.View

  template: JST['apps/index']

  events:
    'click #new_app': 'newApp'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(apps: @collection))
    @appendForm()
    this

  newApp: (event) ->
    event.preventDefault()

  appendForm: ->
    app = new Crashdesk.Models.App()
    form = new Crashdesk.Views.AppsForm(app)
    $('#content').append(form.render().el)
