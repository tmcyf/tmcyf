class StripeCompensator
  # Add domain logic to this file
  def self.compensate(amount)
    amount * 1.03 + 30
  end

end
