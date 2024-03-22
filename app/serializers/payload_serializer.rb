class PayloadSerializer < Panko::Serializer
  include ImagableSerializer
  attributes :id, :email, :name, :gender, :height, :weight, :age, :nickname
end
