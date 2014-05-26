class Sermon < ActiveRecord::Base
  mount_uploader :audio, AudioUploader
end
