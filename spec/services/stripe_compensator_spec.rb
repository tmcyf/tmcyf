require_relative '../../app/services/stripe_compensator.rb'

describe StripeCompensator do
  let(:original) { 500 }
  it 'adds 30c plus 3% to the given amount in cents' do
    StripeCompensator.compensate(original).should == (500 * 1.03 + 30)
  end
    
end
