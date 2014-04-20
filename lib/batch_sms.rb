class BatchSMS
  include Celluloid
  trap_exit record_failures

  def initialize(sms, numbers)
    @sms = sms
    @numbers = numbers
    @failed = []
  end

  # call send! 
  # if it fails, the SMSClient actor will die silently
  def send
    numbers.map do |number|
      self.link SMSWorker.new(@sms, number).send!
    end
  end

  def record_failures(worker, reason)
    @failed << worker.number
  end

end
