class SMS
  attr_accessor :message

  def initialize(message, number)
    begin 
      message.encode(Encoding::ISO_8859_1)
      @message = message
    rescue Encoding::UndefinedConversionError
      raise InvalidEncodingError, "You input a chacter that SMSes can't read."
    end
  end

  class InvalidEncodingError < StandardError
  end
end
