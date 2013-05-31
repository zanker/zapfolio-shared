class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Paranoia

  key :full_name, String
  key :username, String
  key :email, String, :format => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  key :provider_sub, Integer, :default => 0, :numeric => true
  key :timezone, String
  key :oauth, Hash, :default => {}
  key :location, Hash, :default => {}
  key :flags, Hash, :default => {}
  key :jobs, Hash, :default => {}
  key :about, String

  key :uid, String, :required => true
  key :provider, String, :required => true
  key :remember_token, String, :unique => true

  key :current_sign_in_at, Time
  key :last_sign_in_at, Time

  ensure_index [[:provider, Mongo::ASCENDING], [:uid, Mongo::ASCENDING]]
  ensure_index :remember_token

  timestamps!
  safe

  many :albums, :dependent => :destroy
  many :medias, :dependent => :destroy
  many :tags, :dependent => :destroy
  one :subscription
  one :website

  def display_name
    self.full_name? ? self.full_name : self.username
  end

  def has_feature?(type)
    plan = self.subscription ? self.subscription.plan : :free
    !!CONFIG[:subscriptions][plan][:features][type]
  end

  def feature_limit(type)
    plan = self.subscription ? self.subscription.plan : :free
    CONFIG[:subscriptions][plan][:features][type]
  end
end