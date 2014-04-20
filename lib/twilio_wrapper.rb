class TwilioWrapper
  def initialize(twilio_client=nil)
    @twilio_client = twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV['TWILIO_SID'],
                                                ENV['TWILIO_TOKEN'])
  end

  def send_message(number, message)
    @twilio_client.account.messages.create(
      from: "+1#{ENV['TWILIO_NUMBER']}",
      to: number,
      body: message
    )
  end
end
