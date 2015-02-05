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
    # Pulls in params from Twilio request
    # Converts the number to a name, if the name exists in the database.
    # Creates a payload to send to Slack as JSON
    msg_body = params["Body"]
    from_num = params["From"]
    from_name = SMS.convert(from_num)
    payload = {
      text: "From: #{from_name}. Message: #{msg_body}"
    }.to_json

    uri = URI('https://hooks.slack.com/services/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')
    @res = Net::HTTP.post_form(uri, 'payload' => payload)

    render json: @res
  end

end
