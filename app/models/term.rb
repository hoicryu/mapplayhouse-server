class Term < ApplicationRecord
  INDEX_PERMIT = [:_type_eq].freeze
  enum _type: { login: 0, application: 1 }
  ransacker :_type, formatter: proc {|v| _types[v]}
end
