class BannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def filename
    "#{secure_token}#{original_filename.truncate(200, omission: '')}.#{file.extension}" if original_filename.present?
  end

  process :right_orientation
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  version :banner do
    process resize_to_fill: [825, 550]
  end

  def right_orientation
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
