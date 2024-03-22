module ImagableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :image_path

    delegate :image_path, to: :object
  end
end
