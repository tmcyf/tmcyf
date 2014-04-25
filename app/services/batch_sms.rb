class BatchSMS

  def initialize(sms, numbers, sms_client)
    @sms = sms
    @numbers = numbers
    @sms_client = sms_client
  end

  # returns list of [number, exception] pairs
  def send_message!
    @numbers.map do |number|
      @sms_client.send_message!(number, @sms.message)
    end
  end

end
