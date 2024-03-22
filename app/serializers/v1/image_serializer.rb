module V1
  class ImageSerializer < V1::BaseSerializer
    attributes :id, :image_path

    delegate :image_path, to: :object
  end
end
