class SmsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:receive_sms]

  def new_sms
    # validate that user is an admin
    redirect_to :root unless current_user && current_user.admin?
  end

  def send_sms
    begin
      sms = SMS.new(params[:message])
      numbers = User.where(sms_contact: true).pluck(:phone)
      results = BatchSMS.new(sms, numbers, TwilioService).send_message!
      flash.update(SmsResultPresenter.present_hash(results))
    rescue SMS::InvalidEncodingError => e
      flash[:error] = e.message
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
