module Likable
  extend ActiveSupport::Concern
  included do
    has_many :received_likes, as: :target, class_name: "Like", dependent: :destroy

    def is_liked?(_user)
      received_likes.exists?(user: _user)
    end
  end
end
