require_relative '../../app/services/stripe_service.rb'

describe StripeService do
  let(:payable) { double(amount: 5.00) }

  context 'given a user with an invalid stripe_id' do
    let(:user) { double(stripe_id: nil) }

    it 'rejects payments' do
      expect do
        StripeService.new(user).submit_payment_for!(payable)
      end.to raise_error StripeService::NoStripeIdError
    end
  end

  context 'given a user with a valid stripe_id' do
    let(:user) { double(stripe_id: 'mock-id') }

    it 'submits payments to Stripe' do
      stripe = StripeService.new(user)
      expect(stripe).to receive(:create_payment!).with(payable.amount,
                                                       'mock-id')
      stripe.submit_payment_for!(payable)
    end
  end

end
