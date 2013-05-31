class DynamicPage < Page

  ALBUMS, ABOUT, CONTACT = 0, 1, 2

  key :config, Hash, :default => {}
  key :dyn_type, Integer
end