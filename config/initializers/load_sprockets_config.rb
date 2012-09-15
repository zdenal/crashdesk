raw_config = File.read(File.join(Rails.root.to_s, 'config', 'sprockets.yml'))
SPROCKETS_CONFIG = YAML.load(raw_config)

# Add own manifest for compiling
Rails.application.config.assets.precompile += SPROCKETS_CONFIG[:css_source_files]
Rails.application.config.assets.precompile += SPROCKETS_CONFIG[:js_source_files]
