# == Schema Information
#
# Table name: featured_events
#
#  id         :integer          not null, primary key
#  image_url  :string(255)
#  event_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FeaturedEvent < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader

  belongs_to :page
end
