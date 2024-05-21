class V1::MusicalSerializer < V1::BaseSerializer
  include ImagableSerializer
  # include 
  attributes :id, :title, :body, :_type
end