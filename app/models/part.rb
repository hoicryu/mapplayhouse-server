class Part < ApplicationRecord
  include ImageUrl
  belongs_to :musical
  belongs_to :rating
end
