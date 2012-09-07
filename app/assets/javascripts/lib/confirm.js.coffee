class @Confirm

  constructor: ->
    notifier = new Backbone.Notifier
      message: 'Are you sure?'
      modal: true
      position: 'center'
      buttons: [
        {'data-role': 'yes', text: 'Yes'}
        {'data-handler': 'destroy', text: 'No'}
      ]
    return notifier
