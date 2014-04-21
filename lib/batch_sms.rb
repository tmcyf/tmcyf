require 'sms_worker'

class BatchSMS
  include Celluloid
  trap_exit :record_failures

  def initialize(sms, numbers, client)
    @sms = sms
    @numbers = numbers
    @client = client
    @failed = []
  end

  # call send!
  # if it fails, the SMSClient actor will die silently
  def send_message
    @numbers.map do |number|
      SMSWorker.new_link(@sms, number, @client).async.send_message
    end
  end

  def record_failures(worker, reason)
    @failed << worker.number
  end

end
