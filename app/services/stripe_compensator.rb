class StripeCompensator
  # Add domain logic to this file
  def self.compensate(amount)
    amount = (amount + 30)/0.971
    amount.to_i
  end

end
