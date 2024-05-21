class V1::PartEachSerializer < V1::BaseSerializer
  attributes :id, :musical_id, :rating_id, :title, :image
  has_one :rating, serializer: V1::RatingSerializer
end