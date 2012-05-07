class Crashdesk.Views.AppsIndex extends Backbone.View
  id: 'apps'

  template: JST['apps/index']

  events:
    'click #new_app': 'newApp'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependApp, this)

  render: ->
    $(@el).html(@template(apps: @collection))
    @collection.each(@appendApp)
    this

  newApp: (event) ->
    event.preventDefault()
    app = new Crashdesk.Models.App()
    form = @collection.get_form app
    $(@el).append(form.render().el)

  appendApp: (app) =>
    app = new Crashdesk.Views.AppRow({ model: app, collection: @collection })
    this.$('#apps_list').append(app.render().el)

  prependApp: (app) =>
    app = new Crashdesk.Views.AppRow({ model: app, collection: @collection })
    this.$('#apps_list').prepend(app.render().el)
