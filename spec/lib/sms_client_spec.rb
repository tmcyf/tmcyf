describe BatchSMS do
  context 'with valid messages' do
    it 'successfully sends twilio requests' do
      let(:sms) { stub(message: "yo"
                       number: "8675309") }
      # TODO: everything lol
    end
  end
end
