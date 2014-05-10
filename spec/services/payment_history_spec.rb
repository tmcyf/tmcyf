require_relative '../../app/services/payment_history.rb'

describe PaymentHistory do
  let(:user) { double }
  let(:payment) { double }

  before do
    payment_model = double
    payment_model.stub(all: [payment])
    stub_const('Payment', payment_model)
  end

  it 'finds unpaid payments by users' do
    user.stub(payments: [])
    PaymentHistory.new(user).unpaid.should include(payment)
  end

  it 'finds paid payments by users' do
    user.stub(payments: [payment])
    PaymentHistory.new(user).paid.should include(payment)
  end
end
