class Group < ApplicationRecord
  include ImageUrl
  include Imagable
  INDEX_PERMIT = [:status_eq].freeze
  belongs_to :musical

  enum status: { recruiting: 0, closed: 1 , upcomming: 2, done: 3}
end
