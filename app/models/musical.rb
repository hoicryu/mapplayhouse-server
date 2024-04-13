class Musical < ApplicationRecord
  include ImageUrl
  include Imagable
  mount_uploader :image, ImageUploader

  enum _type: { small: 0, big: 1, theatrical: 2 }
end
