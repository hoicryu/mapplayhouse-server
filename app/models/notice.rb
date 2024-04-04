class Notice < ApplicationRecord
  include Positionable
  validates :title, presence: true
  validates :body, presence: true

  enum status: [:visible, :invisible]
  enum _type: [:notice, :event, :application]
  ransacker :status, formatter: proc {|v| statuses[v]}
  ransacker :_type, formatter: proc {|v| types[v]}
end
