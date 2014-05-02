class SmsResultPresenter

  def self.present_hash(batch_sms_result)
    result = {}

    successes = successes_from(batch_sms_result)
    failures = failures_from(batch_sms_result)

    unless successes.empty?
      result[:success] = "Messages successfully sent to #{successes.count} out of #{successes.count + failures.count} numbers." 
    end

    unless failures.empty?
      failure_messages = failures.map { |num, err| "#{num} (#{err.message})" }
      failure_list = readable_list(failure_messages)
      result[:error] = "Messages failed to be sent to #{failure_list}." 
    end

    result
  end

  def self.successes_from(batch_sms_result)
    batch_sms_result.select { |number, error| error.nil? }.map(&:first)
  end

  def self.failures_from(batch_sms_result)
    batch_sms_result.reject { |number, error| error.nil? }
  end

  private
  def self.readable_list(list)
    list.join(', ').chomp(', ')
  end
end
