class Crashdesk.Models.Collaborator extends Backbone.Model
  urlRoot: 'api/collaborators'

  decorator: ->
    @_decorator ||= new Crashdesk.Decorators.Collaborator(@)
