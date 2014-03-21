class FeaturedEvent < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader

  belongs_to :page
end
