module ImageUrl
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ImageUploader
  end

  def image_path(size = :square)
    image? ? image.url(size) : ""
  end

  def upload_image_path(size = :square)
    image? ? image.url(size) : ""
  end
end
