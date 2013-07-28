class Payment < ActiveRecord::Base
  has_one :user, through: :credit_card
  belongs_to :credit_card
  belongs_to :event
end
