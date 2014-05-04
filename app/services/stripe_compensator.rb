class StripeCompensator
  # Add domain logic to this file
  def self.compensate(amount)
    amount = amount * 1.03 + 30
    amount.to_i
  end

end
