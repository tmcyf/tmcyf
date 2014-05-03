class StripeService
  def initialize(token)
    @token = token
  end


  def charge!(amount)
    Stripe::Charge.create(amount: amount, currency: 'USD', card: @token)
  end

end
