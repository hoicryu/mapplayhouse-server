class Reservation < ApplicationRecord
  belongs_to :user

  enum status: { rejected: 0, before: 1 , approved: 2}

  scope :not_rejected, -> { where.not(status: 'rejected') }
end
