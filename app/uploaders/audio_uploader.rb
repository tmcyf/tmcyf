class AudioUploader < CarrierWave::Uploader::Base
  storage :fog

  def extension_white_list
    %w(mp3) # TODO: extend this as necessary
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
  "#{Rails.root}/tmp/uploads"
  end
end
