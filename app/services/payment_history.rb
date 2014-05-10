class PaymentHistory

  def initialize(user)
    @user = user
  end

  def paid
    @user.payments
  end

  def unpaid
    Payment.all - paid
  end
end
