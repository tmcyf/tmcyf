class ContactController < ApplicationController

  def send_sms
    # validate that user is an admin
    redirect_to :root unless current_user && current_user.admin?
  end

  def send_all_message
    message_chunks = params[:message].scan(/.{155}/)
    numbers_to_sms = User.where(sms_contact: true).pluck(:phone)
    # if any of these numbers are nil, the text_contact call will fail and
    # return false
    numbers_to_sms.each do |number| 
      message_chunks.each_with_index do |message, index|
        text_contact(message + "#{index}/#{message_chunks.length}", number)
      end
    end
    redirect_to send_sms_path
  end

  private
  def text_contact(message, contact_number)
    if contact_number
      @twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
      @twilio_client.account.sms.messages.create(
        :from => "+1#{ENV['TWILIO_NUMBER']}",
        :to => contact_number,
        :body => message
      )
      flash[:notice] = "Message sent!"
    else
      return false
    end
    return true
  end
end
