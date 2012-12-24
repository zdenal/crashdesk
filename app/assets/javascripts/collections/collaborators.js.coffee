class Crashdesk.Collections.Collaborators extends Backbone.Collection

  model: Crashdesk.Models.Collaborator

  url: ->
    "/api/collaborators?app_id=#{@app.id}"

  set_app: (app) ->
    @app = app
    @

  get_form: () ->
    unless @app?
      throw 'Please define app for collaborators by "set_app"'
    new Crashdesk.Views.CollaboratorsForm
      model      : new Crashdesk.Models.Collaborator
      app        : @app
      collection : @
