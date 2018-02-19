class SMS
  attr_accessor :message

  def initialize(message)
    begin
      message.encode(Encoding::ISO_8859_1)
      @message = message
    rescue Encoding::UndefinedConversionError
      raise InvalidEncodingError, "You input a character that SMSes can't read."
    end
  end

  # def self.convert(from_num)

  #   # This method can probably be refactored but I don't know enough to attempt it. I'm just glad it works.
  #   # It pulls in variable from controller, strips out country code, checks if user with number exists in DB
  #   # and spits out a full name. The fullname method is borrowed from the User model. If user doesn't exist
  #   # it returns the stripped number.

  #   from_num = from_num.gsub(/^\+\d/, "")
  #   if User.exists?(:phone => from_num)
  #     from_name = User.find_by_phone("#{from_num}").fullname
  #   else
  #     from_name = from_num
  #   end
  # end

  class InvalidEncodingError < StandardError
  end
end
