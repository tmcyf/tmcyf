class Payment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  # need some stripe test harnesses to test this
  def refund
    begin
      Stripe::Charge.retrieve(self.stripe_id).refund
      self.refunded = true
    rescue StripeError => e
      logger.info(e)
      throw e
    end
  end
end
