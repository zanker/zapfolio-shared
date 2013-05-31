require "dragonfly"

Dragonfly[:images].configure_with(:rails)
Dragonfly[:images].define_macro_on_include(MongoMapper::Document, :image_accessor)

