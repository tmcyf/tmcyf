require 'spec_helper'

describe IcsGenerator do
  describe 'events_ics' do
    let(:event) { build(:event, title: 'Test Event') }

    it 'delegates to Icalendar' do
      IcsGenerator::Calendar.should_receive(:new).and_call_original
      IcsGenerator.ics_for(event)
    end
  end
end
