class SMSController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:receive_sms]

  def new_sms
    # validate that user is an admin
    redirect_to :root unless current_user && current_user.admin?
  end

  def send_sms
    begin
      sms = SMS.new(params[:message])
      numbers = User.where(sms_contact: true).pluck(:phone)
      BatchSMS.new(sms, numbers).send!
    rescue InvalidEncodingError => e
      flash[:error] = e
    end
    redirect_to send_sms_path
  end

  def receive_sms
    msg_body = params["Body"]
    from_num = params["From"]

    payload = {
      text: "From: #{from_num}. Message: #{msg_body}"
    }.to_json

    uri = URI('https://tmcyf.slack.com/services/hooks/incoming-webhook?token=lFAo4KrEmegGC3IoBnbfYvdP')
    @res = Net::HTTP.post_form(uri, 'payload' => payload)

    render json: @res
  end

end