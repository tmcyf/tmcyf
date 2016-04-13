require_relative '../../app/services/stripe_compensator.rb'

describe StripeCompensator do
  # Test cases should be big numbers so that we can better expose floating
  # point errors
  let(:originals) { [5000, 8800, 13349] } # aka $50.00, $88.00, $133.49
  it "should equal the original when Stripe's cut is subtracted" do
    originals.each do |original|
      compensated_price = StripeCompensator.compensate(original)
      stripe_fee = (0.029 * compensated_price + 30).round
      price_after_fee = compensated_price - stripe_fee
      expect(price_after_fee).to eq(original)
    end
  end
    
end
