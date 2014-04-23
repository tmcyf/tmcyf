class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :payable, polymorphic: true
  def create(amount, customer)
    Stripe::Charge.create(amount: amount, currency: 'USD', customer: customer) 
  end
end
