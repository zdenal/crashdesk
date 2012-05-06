class Crashdesk.Models.Error extends Backbone.Model

  css_warning_level: ->
    _no = @get('no')
    if _no < 10
      return 'info'
    else if _no < 30
      return 'warning'
    else if _no < 70
      return 'important'
    else
      return 'inverse'
