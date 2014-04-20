class SMSWorker
  include Celluloid
  attr_accessor :number

  def initialize(sms, number)
    @sms = sms
    @number = number
    @twilio_client = Twilio::REST::Client.new(ENV['TWILIO_SID'],
                                              ENV['TWILIO_TOKEN'])
  end

  # call send! 
  # if it fails, the SMSClient actor will die silently
  def send
    @twilio_client.account.messages.create(
      from: "+1#{ENV['TWILIO_NUMBER']}",
      to: @number,
      body: @sms.message
    )
  end
end
