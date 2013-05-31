class Tag
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Paranoia

  ensure_index [[:user_id, Mongo::ASCENDING]]

  belongs_to :user

  timestamps!
  safe
end