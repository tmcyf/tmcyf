require 'rails_helper'

describe EventsController do

  describe 'show' do
    before do
      @event = create(:event, title: 'DogeYF')
    end

    context 'format is ics' do
      it 'responds with success' do
        get :show, format: 'ics', id: @event.id
        expect(response).to be_success
      end

      it 'delegates to IcsGenerator' do
        generator = double(event_ics: 'NEW CALENDAR ICS MAGIC')
        expect(IcsGenerator).to receive(:ics_for).and_return(generator)

        get :show, format: 'ics', id: @event.id
      end
    end
  end

end