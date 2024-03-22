class User < ApplicationRecord
  paginates_per 8
  
  include ImageUrl

  INDEX_PERMIT = [:s, { s: [] }, :user_rooms_room_id_eq].freeze
  USER_COLUMNS = %i[name email phone accept_sms accept_email agree_tos agree_privacy].freeze
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, :trackable

  
  enum gender: { unknown: 0, male: 1, female: 2 }

  def is_like?(target = nil)
    likes.where(target: target).present? if target
  end
end
