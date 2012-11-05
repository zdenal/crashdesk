#= require './bootstrap-datepicker'
#= require './templates/label'
#= require './templates/select'
#= require './templates/text_field'
#= require './templates/date_field'
#= require './templates/text_area'
#= require './templates/check_box'

class @FormHelper

  constructor: (@model, @options) ->
    if @options? and @options['name']?
      @name = @options['name']
    else
      @name = @model.constructor.name.toLowerCase()

  label: (attr, title, html_options={}) ->
    if _.isObject(title) or !title?
      [title, html_options] = [@attr2name(attr), {}]
    JST['form_helper/templates/label'] @basics4attr(attr, title, html_options)

  text_field: (attr, value, html_options={}) ->
    if _.isObject(value)
      [html_options, value] = [value, null]
    JST['form_helper/templates/text_field'] @basics4attr(attr, value, html_options)

  text_area: (attr, value, html_options={}) ->
    if _.isObject(value)
      [html_options, value] = [value, null]
    JST['form_helper/templates/text_area'] @basics4attr(attr, value, html_options)

  check_box: (attr, value, html_options={}) ->
    if _.isObject(value)
      [html_options, value] = [value, null]
    title = html_options.title; delete html_options.title
    attrs = @basics4attr(attr, value, html_options)
    attrs.title = title
    JST['form_helper/templates/check_box'] attrs

  date_field: (attr, html_options={}) ->
    JST['form_helper/templates/date_field'] @basics4attr(attr, value?, html_options)

  select: (attr, options, html_options={}) ->
    attrs = @basics4attr(attr, html_options)
    attrs.values = options.values
    attrs.value ||= options.selected
    JST['form_helper/templates/select'] attrs

  select_tag: (name, options, html_options={}) ->
    attrs =
      field_name     : name
      values         : options.values
      value          : options.selected
      unfold_options : @unfold_options html_options
      field_id       : name
    JST['form_helper/templates/select'] attrs

  #
  #
  #
  field_id: (attr) ->
    "#{@name}_#{attr}"

  field_name: (attr) ->
    "#{@name}[#{attr}]"

  unfold_options: (options) ->
    unfolded = for key, value of options
      "#{key}=\"#{value}\""
    unfolded.join(' ')

  attr2name: (attr) ->
    attr = @capitalize attr
    attr = attr.replace /_/g, ' '
    attr

  basics4attr: (attr, value, html_options) ->
    errors = @model.errors?[attr] or @model.get('errors')?[attr]
    if errors
      html_options.class = html_options.class?.concat(' error') or 'error'
    attrs =
      unfold_options: @unfold_options html_options
      field_id: @field_id(attr)
      field_name: @field_name(attr)
      value: value or @model.get attr
      errors: errors
    attrs

  capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.slice(1);
