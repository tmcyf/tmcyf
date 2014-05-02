class PaymentHistory

  def initialize(user)
    @user = user
  end

  def paid
    Payment.find(@user.charges.pluck(:payment_id))
  end

  def unpaid
    Payment.all - paid
  end
end
