class CurrentUserSerializer < Panko::Serializer
  include ImagableSerializer
  attributes :id, :email, :name, :height, :weight, :age, :nickname
end
