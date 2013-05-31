class Website
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Paranoia

  image_accessor :favicon
  image_accessor :logo

  key :domain, String
  key :subdomain, String
  key :css, String
  key :max_width, Integer, :default => 0
  key :width_unit, String, :default => "%"

  many :pages
  belongs_to :user

  timestamps!
  safe
end