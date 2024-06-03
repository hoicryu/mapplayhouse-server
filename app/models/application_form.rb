class ApplicationForm < ApplicationRecord
  PERMIT_COLUMNS = [:group_id, :name, :birthday, :phone, :signature, { part_ids: [] }].freeze
  belongs_to :group
  belongs_to :user
end
