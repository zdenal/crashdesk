class @EndlessScroller

  constructor: (options) ->
    @window = $(options.window)
    @list = $(options.list)
    @window.scroll =>
      if @isOnBottom()
        $.getJSON options.url, (data) ->
          options.collection.add data

  isOnBottom: ->
    if $(@window).scrollTop() > $(@list).height() - $(@window).height() - 50
      true
    else
      false
