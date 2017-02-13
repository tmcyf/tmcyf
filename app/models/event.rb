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

  validate :check_dimensions, :on => :create

  def check_dimensions
    if !image_cache.nil? && (image.width != 1000 || image.height != 400)
      errors.add(:image, "The image dimensions are not 1000 x 400! Please resize and try again.")
    end
  end

  extend FriendlyId
  include Payable
  has_many :payments, as: :payable
  # without :finders, we need to use Event.friendly.find in all cases
  friendly_id :title, use: :slugged

  def to_ics
    event = Icalendar::Event.new
    event.start = self.startdt.strftime("%Y%m%dT%H%M%S")
    event.end = self.enddt.strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.body
    event.location = self.location
    event.klass = "PUBLIC"
    event.uid = event.url = "#{PUBLIC_URL}events/#{self.title}"
    event
  end
end
