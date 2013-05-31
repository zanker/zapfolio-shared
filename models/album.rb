class Album
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Paranoia

  after_update :reload_on_change
  after_create :reload_photos

  PUBLIC, PRIVATE, MIXED = 0, 1, 2

  key :title, String
  key :description, String
  key :privacy, Integer, :default => PRIVATE
  key :password, String
  key :provider_id, String
  key :provider, String
  key :cnt_photos, Integer, :default => 0
  key :cnt_videos, Integer, :default => 0
  key :prov_created, Time
  key :prov_updated, Time
  key :prov_info, Hash, :default => {}
  key :jobs, Hash, :default => {}

  ensure_index [[:user_id, Mongo::ASCENDING], [:provider, Mongo::ASCENDING], [:provider_id, Mongo::ASCENDING]]

  belongs_to :user
  many :medias, :dependent => :destroy

  timestamps!
  safe

  private
  def reload_on_change
    if self.prov_updated_changed?
      reload_photos
    end
  end

  def reload_photos
    uuid = Job::Flickr::AlbumMedia.create(:album_id => self._id)
    User.set({:_id => self.user_id}, {"jobs.album_#{self._id}" => uuid})
  end
end