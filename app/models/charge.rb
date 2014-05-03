class Charge < ActiveRecord::Base
  validates_presence_of :stripe_id, :last4, :amount, :user, :payment
  belongs_to :user
  belongs_to :payment
end
