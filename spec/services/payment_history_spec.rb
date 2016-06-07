require_relative '../../app/services/payment_history.rb'

describe PaymentHistory do
  let(:user) { double }
  let(:payment) { double }

  before do
    payment_model = double
    allow(payment_model).to receive_messages(active: [payment])
    stub_const('Payment', payment_model)
  end

  it 'finds unpaid payments by users' do
    allow(user).to receive_messages(payments: [])
    expect(PaymentHistory.new(user).unpaid).to include(payment)
  end

  it 'finds paid payments by users' do
    allow(user).to receive_messages(payments: [payment])
    expect(PaymentHistory.new(user).paid).to include(payment)
  end
end
