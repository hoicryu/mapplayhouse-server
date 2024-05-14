class Rating < ApplicationRecord
  has_many :groups
  enum status: { main: 0, supporting: 1, ensemble: 2}
  ransacker :status, formatter: proc {|v| statuses[v]}
end
