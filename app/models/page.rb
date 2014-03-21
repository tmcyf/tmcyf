class Page < ActiveRecord::Base
  has_many :featured_event

  accepts_nested_attributes_for :featured_event
end