require 'spec_helper'

describe IcsGenerator do
  describe 'events_ics' do
    let(:event) { build(:event, title: 'Test Event') }

    it 'delegates to Icalendar' do
      expect(IcsGenerator::Calendar).to receive(:new).and_call_original
      IcsGenerator.ics_for(event)
    end
  end
end
