class StripeService
  def initialize(token)
    @token = token
  end


  def charge!(amount, description="")
    Stripe::Charge.create(amount: amount, currency: 'USD', card: @token,
                          description: description)
  end

end
