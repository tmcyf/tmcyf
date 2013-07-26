class Event < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	extend FriendlyId
	friendly_id :title, use: :slugged
end
