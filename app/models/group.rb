class Group < ApplicationRecord
  belongs_to :musical

  enum status: { recruiting: 0, closed: 1 }
end
