class StripeService
  def initialize(token)
    @token = token
  end

  def submit_payment_for!(payable)
    charge = nil
    begin
      charge = create_payment!(payable.amount)
    rescue Stripe::CardError => e
      # payment declined
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    end
    return charge
  end

  def create_payment!(amount)
    charge = Stripe::Charge.create(amount: amount, currency: 'USD', customer: @token)
    charge.values_at(:id, :amount).merge(last4: charge.card.last4)
  end

end
