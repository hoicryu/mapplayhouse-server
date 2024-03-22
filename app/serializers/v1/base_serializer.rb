module V1
  class BaseSerializer < Panko::Serializer
    attributes :model_name

    def model_name
      object.class.name
    end
  end
end
