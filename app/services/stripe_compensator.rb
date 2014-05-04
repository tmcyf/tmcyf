class StripeCompensator
  # Add domain logic to this file
  def self.compensate(amount)
    ((amount + 30) / 0.971).round
  end

end
