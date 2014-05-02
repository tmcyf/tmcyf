require_relative '../../app/services/sms_result_presenter.rb'

describe SmsResultPresenter do
  let(:twilio_error) { double(message: "an error occurred.") }

  let(:results) { [ 
    ['8675309', nil],
    ['5555555', twilio_error]
  ] }

  it "filters successes from failures correctly" do
    SmsResultPresenter.successes_from(results).should == ['8675309']
    SmsResultPresenter.failures_from(results).should == [['5555555', twilio_error]]
  end

  context "with no failures" do
    let(:results) { [ ['8675309', nil] ] }

    it "returns the count of successful numbers" do
      SmsResultPresenter.present_hash(results)[:success].should match "Messages successfully sent to 1 out of 1 numbers."
    end
  end

  context "with no successes" do
    let(:results) { [ ['5555555', twilio_error] ] }

    it "returns the list of failed numbers and errors" do
      res = SmsResultPresenter.present_hash(results)[:error]
      res.should match(/Messages failed.*5555555.*#{Regexp.quote(twilio_error.message)}/)
    end
  end

  context "with both successes and failures" do
    let(:results) { [ 
      ['8675309', nil],
      ['5555555', twilio_error]
    ] }
    it "shows both failures and successes" do
      SmsResultPresenter.present_hash(results)[:success].should match "Messages successfully sent to 1 out of 2 numbers."
      SmsResultPresenter.present_hash(results)[:error].should match(/Messages failed.*5555555.*#{Regexp.quote(twilio_error.message)}/)
    end
  end

end
