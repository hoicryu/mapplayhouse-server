class Group < ApplicationRecord
  include Imagable
  INDEX_PERMIT = [:status_eq].freeze
  has_many :application_forms
  has_many :user_groups
  belongs_to :musical

  enum status: { recruiting: 0, proceeding: 1 , performance_upcomming: 2, done: 3}
  ransacker :status, formatter: proc {|v| statuses[v]}

  scope :can_rental, -> { where.not(status: :done) }
end
