class OdrMailer < ActionMailer::Base
  default from: 'hello@tmcyf.org'

  def registration_confirmation(registration)
    @registration = registration
    mail(to: @registration.email, subject: "Congrats! You've registered for One Day Retreat!")
  end

  def payment_confirmation(email)
    @email = email
    mail(to: email, subject: "Awesome! You've paid!")
  end
end