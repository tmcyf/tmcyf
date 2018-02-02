class SmsController < ApplicationController
  include ActionView::Helpers::NumberHelper

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
    from_num = params["From"]
    from_num = from_num.gsub(/^\+\d/, "")
    msg_body = params["Body"]

    sender_exists = User.exists?(phone: from_num)
    sender = User.find_by(phone: from_num)

    begin
      if sender_exists
        response = process_message(msg_body, sender)
      else
        payload = {
          text: "From: Unknown (#{from_num}). Message: #{msg_body}"
        }.to_json

        uri = URI('https://hooks.slack.com/services/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') ## textbot
        @res = Net::HTTP.post_form(uri, 'payload' => payload)

        response = "Unknown number, sending to Slack."
      end
    end

    render json: { message: response }, status: :ok
  end

  private

  def process_message(msg_body, sender)
    sender_name = sender.fullname
    sender_phone = sender.phone

    if msg_body.match(/(?i)(^register$)/) && sender.active?

      "User is already registered"

    elsif msg_body.match(/(?i)(^register$)/)
      sender.active!
      payload = {
      text: "#{sender_name} just registered for the year! Now go make sure they pay their dues!"
      }.to_json

      uri = URI('https://hooks.slack.com/services/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') ## registerbot
      @res = Net::HTTP.post_form(uri, 'payload' => payload)

      "User is active"
    else

      payload = {
        text: "From: #{sender_name} (#{sender_phone}). Message: #{msg_body}"
      }.to_json

      uri = URI('https://hooks.slack.com/services/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') ## textbot
      @res = Net::HTTP.post_form(uri, 'payload' => payload)

      response = "Registered member, sending text to Slack."
    end

  end
end
