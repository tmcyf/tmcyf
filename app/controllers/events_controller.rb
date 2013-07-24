class EventsController < ApplicationController
	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.save

		redirect_to events_path
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		@event.update(event_params)

		flash.notice = "Event '#{@event.title}' Updated!"

		redirect_to events_path
	end


	def destroy
		@event = Event.find(params[:id])
		@event.destroy

		redirect_to events_path
	end



	def event_params
		params.require(:event).permit(:title, :body, :date, :time, :location)
	end	
end
