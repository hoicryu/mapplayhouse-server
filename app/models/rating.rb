class Rating < ApplicationRecord
  has_many :parts
  enum status: { main: 0, supporting: 1, ensemble: 2}
  ransacker :status, formatter: proc {|v| statuses[v]}
end
