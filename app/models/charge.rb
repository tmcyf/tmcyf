class Charge < ActiveRecord::Base
  validates_presence_of :stripe_id, :last4, :amount, :user_id, :payment_id
  belongs_to :user
  belongs_to :payment
end
