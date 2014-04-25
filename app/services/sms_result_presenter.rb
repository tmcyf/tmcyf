class SmsResultPresenter

  def self.present(batch_sms_result)
    successes = successes_from(batch_sms_result)
    failures = failures_from(batch_sms_result)
    success_list = successes.join(', ').chomp(', ')
    success_msg = "Messages successfully sent to #{success_list}.\n" unless successes.empty?
    failure_list = failures.join(', ').chomp(', ')
    failure_msg = "Messages failed to be sent to #{failure_list}." unless failures.empty?
    return "#{success_msg} #{failure_msg}"
  end

  def self.successes_from(batch_sms_result)
    batch_sms_result.select { |number, error| error.nil? }.map(&:first)
  end

  def self.failures_from(batch_sms_result)
    batch_sms_result.select { |number, error| !error.nil? }.map(&:first)
  end
end
