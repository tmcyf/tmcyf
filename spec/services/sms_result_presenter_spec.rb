require_relative '../../app/services/sms_result_presenter.rb'

describe SmsResultPresenter do
  let(:twilio_error) { double }

  let(:results) { [ 
    ['8675309', nil],
    ['5555555', twilio_error]
  ] }

  it "filters successes from failures correctly" do
    SmsResultPresenter.successes_from(results).should == ['8675309']
    SmsResultPresenter.failures_from(results).should == ['5555555']
  end

  context "with no failures" do
    let(:results) { [ ['8675309', nil] ] }

    it "returns the list of successful numbers" do
      SmsResultPresenter.present(results).should == "Messages successfully sent to 8675309.\n "
    end
  end

  context "with no successes" do
    let(:results) { [ ['5555555', twilio_error] ] }

    it "returns the list of failed numbers" do
      SmsResultPresenter.present(results).should == " Messages failed to be sent to 5555555."
    end
  end

end
