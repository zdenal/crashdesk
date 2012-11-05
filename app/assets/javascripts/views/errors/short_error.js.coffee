class Crashdesk.Views.ShortError extends Backbone.View
  className : 'error-preview clickable'
  tagName   : 'article'

  template: JST['errors/short_error']

  events:
      'click': 'showEvent'

  initialize: ->
    @model.on 'change', @render, this
    @model.on 'destroy', @remove, this
    @model.on 'change:selected', @changeSelected, this

  render: ->
    $(@el).html(@template(error: @model))
    $("time.timeago").timeago()
    @connectByFirehose()
    this

  showEvent: (e) ->
    e.preventDefault()
    @collection.select(@model)

  showErrorDetail: ->
    @model.fetch
      success: =>
        error_detail = new Crashdesk.Views.ErrorDetail
          model: @model,
          collection: @collection
        $('#error').html(error_detail.render().el)

  showCustomers: ->
    list = new Crashdesk.Views.CustomerList(model: @model)
    $("##{list.id}").remove()
    $('#error').after(list.render().el)

  changeSelected: ->
    if @model.is_selected()
      $(@el).addClass 'selected'
      @showErrorDetail()
      @setPositionInList()
    else
      $(@el).removeClass 'selected'

  setPositionInList: ->
    scrollPosition = this.$el.position().top
    window_height = this.$el.parents('#endless_list').height()
    move_to = ( scrollPosition - this.$el.parent().position().top )
    if scrollPosition > ( window_height - 100) or scrollPosition < 100
      this.$el.parents('#endless_list').scrollTop move_to

  highlight: ->
    $(@el).effect('highlight', {}, 2000)

  # Move this into model
  connectByFirehose: ->
    #new Firehose.Consumer(
      #uri: "//localhost:7474/errors/#{@model.id}"
      #error: =>
        #console.log "#{@model.id} has got error"
      #disconnected: =>
        #console.log "#{@model.id} disconnected via firehose"
      #connected: =>
        #console.log "#{@model.id} connected via firehose"
      #message: (data) =>
        #console.log "#{@model.id} got message"
        #@model.set data
        #@highlight()
    #).connect()
