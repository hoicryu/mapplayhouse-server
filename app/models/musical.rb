class Musical < ApplicationRecord
  include ImageUrl
  include Imagable
  mount_uploader :image, ImageUploader
  
  has_many :parts

  enum _type: { small: 0, big: 1, theatrical: 2 }
end
