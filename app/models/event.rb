class Event < ActiveRecord::Base
	has_many :payments
	mount_uploader :image, ImageUploader
	extend FriendlyId
	friendly_id :title, use: :slugged
end
