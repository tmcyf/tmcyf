class TwilioService

  # returns a [number, exception] pair where exception is nil if none occurred
  def self.send_message!(number, message)
    exception = nil

    begin
      @@from_num ||= "+1#{ENV['TWILIO_NUMBER']}"
      @@twilio_client ||= Twilio::REST::Client.new(ENV['TWILIO_SID'],
                                                   ENV['TWILIO_TOKEN'])

      @@twilio_client.account.messages.create(
        from: @@from_num,
        to: number,
        body: message
      )
    rescue Twilio::REST::RequestError => e
      puts e.message
      exception = e
    end

    [number, exception]
  end
end
