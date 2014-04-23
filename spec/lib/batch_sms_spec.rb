require 'batch_sms'

describe BatchSMS do
  context 'with valid messages' do
    it 'delegates to the twilio wrapper' do
      sms = double(message: 'hello')
      twilio = double(send_message: true)
      numbers = [ '1' ]
      twilio.should_receive(:send_message).with('1', sms.message)
      BatchSMS.new(sms, numbers, twilio).send_message
      sleep 1 # allow the async action to complete
    end
  end
end
