class Page
  include MongoMapper::Document

  PRIVATE, PUBLIC = 0, 1

  key :slug, String
  key :title, String
  key :status, Integer, :default => PRIVATE
  key :body, String

  belongs_to :website

  timestamps!
  safe
end