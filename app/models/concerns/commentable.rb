module Commentable
  extend ActiveSupport::Concern
  included do
    has_many :received_comments, class_name: "Comment", as: :target, dependent: :destroy

    def count_comments
      received_comments.count
    end
  end
end
