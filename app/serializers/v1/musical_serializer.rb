class V1::MusicalSerializer < V1::BaseSerializer
  include ImagableSerializer
  attributes :id, :title, :body, :_type
  has_many :parts, serializer: V1::PartEachSerializer
end