class RetreatMailer < ActionMailer::Base
  default from: 'hello@tmcyf.org'

  def registration_confirmation(retreat)
    @retreat = retreat
    mail(to: @retreat.email, subject: "Congrats! You've registered!")
  end
end