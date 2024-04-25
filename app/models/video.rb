class Video < ApplicationRecord
  belongs_to :group
  enum _type: { performance: 0, practice: 1}

  ransacker :_type, formatter: proc {|v| _type[v]}
end
