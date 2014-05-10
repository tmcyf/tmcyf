class Charge < ActiveRecord::Base
  validates_presence_of :amount, :user, :payment
  belongs_to :user
  belongs_to :payment
end
