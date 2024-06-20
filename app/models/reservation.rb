class Reservation < ApplicationRecord
  belongs_to :user

  enum status: { rejected: 0, before: 1 , approved: 2}
end
