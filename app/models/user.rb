class User < ApplicationRecord
  paginates_per 8
  
  include ImageUrl

  INDEX_PERMIT = [:s, { s: [] }, :user_rooms_room_id_eq].freeze
  USER_COLUMNS = %i[name email phone accept_sms accept_email agree_tos agree_privacy].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum gender: { unknown: 0, male: 1, female: 2 }

  def self.login(provider, uid, email, nickname = nil)
    if (user = User.find_by(provider: provider, uid: uid))
      User.publish_auth({ user_id: user.id, user: PayloadSerializer.new.serialize(user) })
    elsif email && User.find_by(email: email)
      false
    else
      user = User.new(email: email, 
                      name: (nickname || "#{provider}_#{nickname}##{rand(1000...9999)}"),
                      password: Devise.friendly_token,
                      provider: provider, uid: uid
                    )
      user.errors.any? ? false : {user: user, sign_up: true}
    end
  end
  
  def self.publish_auth payload
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    tokens = session.login

    result = { csrf: tokens[:csrf], token: tokens[:access], currentUser: payload[:user] }
    return result
  end

  def is_like?(target = nil)
    likes.where(target: target).present? if target
  end
end
