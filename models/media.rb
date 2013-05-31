class Media
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Paranoia

  PUBLIC, PRIVATE = 0, 1
  PHOTO, VIDEO = 0, 1
  INACTIVE, ACTIVE, SUB_NEEDED = 0, 1, 2

  key :title, String
  key :description, String
  key :tags, Array, :default => []
  key :prov_info, Hash, :default => {}
  key :pub_flag, Integer, :default => INACTIVE
  key :privacy, Integer, :default => PRIVATE
  key :height, Integer, :default => 0
  key :width, Integer, :default => 0
  key :prov_created, Time
  key :prov_updated, Time
  key :album_ids, Array
  key :type, Integer, :default => PHOTO

  key :provider_id, String
  key :provider, String

  ensure_index [[:user_id, Mongo::ASCENDING], [:album_ids, Mongo::ASCENDING]]
  ensure_index [[:user_id, Mongo::ASCENDING], [:provider, Mongo::ASCENDING], [:provider_id, Mongo::ASCENDING]]

  belongs_to :user
  many :albums, :in => :album_ids

  timestamps!
  safe
end