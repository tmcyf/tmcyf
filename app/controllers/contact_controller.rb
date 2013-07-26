class ContactController < ApplicationController

  def contact_all
    # validate that user is an admin
  end

  def send_all_message
    message = params[:message]
    addresses_to_email = User.where(email_contact: true).pluck(:email)
    numbers_to_sms = User.where(sms_contact: true).pluck(:phone)
    numbers_to_sms.each { |number| self.text_contact(message, number) }
    addresses_to_email.each { |address| self.email_contact(message, address)}
    redirect_to contact_all_path
  end

  private
  def text_contact(message, contact_number)
    @twilio_client.account.sms.messages.create(
      :from => "+1#{ENV[TWILIO_NUMBER]}",
      :to => contact_number,
      :body => message
    )
  end
  def email_contact(message, contact_email_address)
    # TODO: integrate mandrill here
  end
end
