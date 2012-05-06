class Crashdesk.Models.Customer extends Backbone.Model

  is_online: ->
    @get('is_online') is yes
