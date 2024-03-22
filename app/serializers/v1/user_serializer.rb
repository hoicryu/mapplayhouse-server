module V1
  class UserSerializer < V1::BaseSerializer
    include ImagableSerializer

    attributes :id, :email, :name, :description, :followers_count, :followings_count, :follow_id, :address1, :address2, :zipcode, :phone, :image_ids

    def followers_count
      object.followers.size
    end

    def followings_count
      object.followings.size
    end

    def follow_id
      follow = nil
      follow = object.follower_relations.find_by(follower_id: context[:current_api_user].id) if context&.dig(:current_api_user).present?
      follow&.id
    end
  end
end
