class Subscription
  include MongoMapper::EmbeddedDocument

  key :plan, String
end