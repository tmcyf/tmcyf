require_relative '../../app/models/sms.rb'

describe SMS do
  it 'initializes correctly' do
    SMS.new('a message')
  end

  it 'rejects characters outside the ASCII encoding' do
    expect do
      SMS.new('ATTACK OF THE CURLY QUOTES ’’’’’’’’’')
    end.to raise_error SMS::InvalidEncodingError
  end

end
