class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum status: { activated: 0, deactivated: 1}
end
