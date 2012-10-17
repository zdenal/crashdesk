# Render Partials in ECO-Templates like in Rails-ERB
# 
# usefull to clean up structure in spine.js and other js-mvc´s like backbone 
# 
# usage:
#   <%- render_partial 'path/to/partial' %>  ..  will render ../spine-app/views/path/to/_partial.jst.eco
#   <%- render_partial 'path/to/partial', foo: 'bar' %>  ..  will render ../spine-app/views/path/to/_partial.jst.eco  ..  locals = @foo 
#
window.render_partial = ( path, options = {} ) ->
	# add the leading underscore (like rails-partials)
	path = path.split('/')
	path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
	path = path.join('/')
	# render and return the partial if existing
	try
		JST[path]( options )
	catch error
		# if App.Environment != 'production' then "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>" else ''
		"<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"

