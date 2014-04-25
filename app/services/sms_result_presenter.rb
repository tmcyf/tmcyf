class SmsResultPresenter

  def self.present(batch_sms_result)
    presentation_data = present_hash(batch_sms_result)
    "#{presentation_data[:successes]} #{presentation_data[:failures]} #{presentation_data[:errors]}"
  end

  def self.present_hash(batch_sms_result)
    successes = successes_from(batch_sms_result)
    failures = failures_from(batch_sms_result)
    errors = errors_from(batch_sms_result)
    success_list = readable_list(successes)
    success_msg = "Messages successfully sent to #{success_list}.\n" unless successes.empty?
    failure_list = readable_list(failures)
    failure_msg = "Messages failed to be sent to #{failure_list}." unless failures.empty?
    error_list = readable_list(errors)
    error_msg = "Errors: #{error_list}" unless errors.empty?
    {successes: success_msg, failures: failure_msg, errors: error_msg}
  end

  def self.successes_from(batch_sms_result)
    batch_sms_result.select { |number, error| error.nil? }.map(&:first)
  end

  def self.failures_from(batch_sms_result)
    batch_sms_result.reject { |number, error| error.nil? }.map(&:first)
  end

  def self.errors_from(batch_sms_result)
    batch_sms_result.map(&:last).reject { |err| err.nil? }.map(&:message).uniq
  end

  private
  def self.readable_list(list)
    list.join(', ').chomp(', ')
  end
end
