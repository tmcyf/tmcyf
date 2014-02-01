class ContactController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:receive_sms]

  def send_sms
    # validate that user is an admin
    redirect_to :root unless current_user && current_user.admin?
  end

  def receive_sms
    msg_body = params["Body"]
    from_num = params["From"]

    payload = {
      :text => "From: #{from_num}. Message: #{msg_body}"
    }.to_json

    uri = URI('https://tmcyf.slack.com/services/hooks/incoming-webhook?token=lFAo4KrEmegGC3IoBnbfYvdP')
    @res = Net::HTTP.post_form(uri, 'payload' => payload)

    render json: @res
  end

  def send_all_message
    # if any of these numbers are nil, the text_contact call will fail and
    # return false
    numbers_to_sms = User.where(sms_contact: true).pluck(:phone)
    if params[:message].length > 160
      numbers_to_sms.each do |number| 
        message_chunks.each_with_index do |message, index|
          text_contact(message + "(#{index+1}/#{message_chunks.length})", number)
        end
      end
    else
      numbers_to_sms.each do |number| 
        text_contact(params[:message], number)
      end
    end
    redirect_to send_sms_path
  end

  private
  def message_chunks
    binding.pry
    # message limit is 160 chars
    # need to leave 6 chars for the msg index (e.g. "(5/6)" or "(5/10)")
    params[:message].scan(/.{1,154}/)
  end
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
