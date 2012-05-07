class Crashdesk.Views.SharedTagManager extends Backbone.View
  className: 'modal hide fade'

  template: JST['shared/tag_manager']

  serialize: ->
    tags        : this.$('input[name="tags"]').val()
