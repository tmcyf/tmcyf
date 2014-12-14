class RetreatMailer < ActionMailer::Base
  default from: 'hello@tmcyf.org'

  def registration_confirmation(retreat)
    @retreat = retreat
    mail(to: @retreat.email, subject: "Congrats! You've registered!")
  end

  def payment_confirmation(email)
    @email = email
    mail(to: email, subject: "Awesome! You've paid!")
  end
end