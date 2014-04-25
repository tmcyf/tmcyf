class SmsResultPresenter

  def self.present(batch_sms_result)
    successes = successes_from(batch_sms_result)
    failures = failures_from(batch_sms_result)
    errors = errors_from(batch_sms_result)
    success_list = list_with_separator(successes,', ')
    success_msg = "Messages successfully sent to #{success_list}.\n" unless successes.empty?
    failure_list = list_with_separator(failures,', ')
    failure_msg = "Messages failed to be sent to #{failure_list}." unless failures.empty?
    error_list = list_with_separator(errors,'\n')
    error_msg = "Errors: #{error_list}" unless errors.empty?
    return "#{success_msg} #{failure_msg} #{error_msg}"
  end

  def self.successes_from(batch_sms_result)
    batch_sms_result.select { |number, error| error.nil? }.map(&:first)
  end

  def self.failures_from(batch_sms_result)
    batch_sms_result.reject { |number, error| error.nil? }.map(&:first)
  end

  def self.errors_from(batch_sms_result)
    batch_sms_result.map(&:last).reject { |error| error.nil? }.map(&:message)
  end

  private
  def self.list_with_separator(list, separator)
    list.join(separator).chomp(separator)
  end
end
