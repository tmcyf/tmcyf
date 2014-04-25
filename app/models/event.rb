# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  location   :text
#  image      :string(255)
#  body       :text
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  startdt    :datetime
#  enddt      :datetime
#

class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  extend FriendlyId
  # without :finders, we need to use Event.friendly.find in all cases
  friendly_id :title, use: :slugged

end
