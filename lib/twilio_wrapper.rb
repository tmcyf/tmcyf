class TwilioWrapper
  def initialize(twilio_client)
    @twilio_client = twilio_client
  end

  def send_message(number, message)
    @twilio_client.account.messages.create(
      from: "+1#{ENV['TWILIO_NUMBER']}",
      to: number,
      body: message
    )
  end
end
