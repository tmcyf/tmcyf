class ContactController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:receive_sms]

  def send_sms
    # validate that user is an admin
    redirect_to :root unless current_user && current_user.admin?
  end

  def receive_sms
    msg_body = params["Body"]
    from_num = params["From"]

    jsonbody = {
      :text => "Text from #{from_num}: #{msg_body}"
    }

    uri = URI.parse("http://requestb.in/19m43211")
    req = Net::HTTP::Post.new(uri.path)
    req.body = JSON.generate(jsonbody)
    req["Content-Type"] = "application/json"
    http = Net::HTTP.new(uri.host, uri.port)
    @response = http.start {|http| http.request(req)}

    render json: @response
  end

  def send_all_message
    message = params[:message]
    numbers_to_sms = User.where(sms_contact: true).pluck(:phone)
    # if any of these numbers are nil, the text_contact call will fail and
    # return false
    numbers_to_sms.each { |number| text_contact(message, number) }
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
