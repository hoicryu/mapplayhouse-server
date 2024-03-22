module LikableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :likes_count

    def likes_count
      object.received_likes.size
    end
  end
end
