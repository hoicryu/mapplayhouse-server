class Reservation < ApplicationRecord
  belongs_to :user

  enum status: { before: 0, approved: 1 , rejected: 2}
end
