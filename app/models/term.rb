class Term < ApplicationRecord
  enum _type: { login: 0, application: 1 }
  ransacker :_type, formatter: proc {|v| _types[v]}
end
