class SMSWorker
  include Celluloid
  attr_accessor :number

  def initialize(sms, number, client)
    @sms = sms
    @number = number
    if client
      @@twilio_client = client
    else 
      @@twilio_client ||= Twilio::REST::Client.new(ENV['TWILIO_SID'],
                                                   ENV['TWILIO_TOKEN'])
    end
  end

  # API: call send! 
  # if it fails, the SMSClient actor will die silently
  def send_message
    @@twilio_client.send_message(@number, @sms.message)
  end
end
