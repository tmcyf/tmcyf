class StripeService
  def initialize(user)
    if user.stripe_id
      @user = user
    else 
      raise NoStripeIdError
    end
  end

  def submit_payment_for!(payable)
    begin
      create_payment!(payable.amount, @user.stripe_id)
    rescue RuntimeError => e
    end
  end

  def create_payment!(amount, stripe_id)
    Stripe::Charge.create(amount: amount, currency: 'USD', customer: stripe_id) 
  end

  class NoStripeIdError < RuntimeError
  end
end
