require_relative '../../app/services/payment_history.rb'

describe PaymentHistory do
  let(:user) { double }
  let(:payment) { double }

  before do
    payment_model = double
    payment_model.stub(active: [payment])
    stub_const('Payment', payment_model)
  end

  it 'finds unpaid payments by users' do
    user.stub(payments: [])
    expect(PaymentHistory.new(user).unpaid).to include(payment)
  end

  it 'finds paid payments by users' do
    user.stub(payments: [payment])
    expect(PaymentHistory.new(user).paid).to include(payment)
  end
end
