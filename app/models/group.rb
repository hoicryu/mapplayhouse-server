class Group < ApplicationRecord
  include Imagable
  INDEX_PERMIT = [:status_eq].freeze
  belongs_to :musical

  enum status: { recruiting: 0, closed: 1 , upcomming: 2, done: 3}
  ransacker :status, formatter: proc {|v| statuses[v]}
end
