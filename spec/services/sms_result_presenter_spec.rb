require_relative '../../app/services/sms_result_presenter.rb'

describe SmsResultPresenter do
  let(:twilio_error) { double(message: "an error occurred.") }

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
      SmsResultPresenter.present(results).should match "Messages successfully sent to 8675309.\n "
    end
  end

  context "with no successes" do
    let(:results) { [ ['5555555', twilio_error] ] }

    it "returns the list of failed numbers and errors" do
      SmsResultPresenter.present(results).should match " Messages failed to be sent to 5555555."
      SmsResultPresenter.present(results).should match "Errors: #{twilio_error.message}"
    end
  end

  context "with both successes and failures" do
    let(:results) { [ 
      ['8675309', nil],
      ['5555555', twilio_error]
    ] }
    it "shows both failures and successes" do
      SmsResultPresenter.present(results).should match "Messages successfully sent to 8675309.\n Messages failed to be sent to 5555555."
      SmsResultPresenter.present(results).should match "Errors: #{twilio_error.message}"
    end
  end

  context "with multiple failures of the same kind" do
    let(:results) { [ 
      ['8675309', twilio_error],
      ['5555555', twilio_error]
    ] }
    it "shows only unique error messages" do
      presentation_data = SmsResultPresenter.present_data(results)
      presentation_data[:errors].should == "Errors: an error occurred."
    end
  end
end
