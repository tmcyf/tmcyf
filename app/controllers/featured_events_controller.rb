class FeaturedEventsController < ApplicationController
  before_action :set_featured_event, only: [:show, :edit, :update, :destroy]

  # GET /featured_events
  def index
    redirect_to :root unless current_user && current_user.admin?
    @featured_events = FeaturedEvent.all
  end

  # GET /featured_events/1
  def show
    redirect_to :root unless current_user && current_user.admin?
  end

  # GET /featured_events/new
  def new
    redirect_to :root unless current_user && current_user.admin?
    @featured_event = FeaturedEvent.new
  end

  # GET /featured_events/1/edit
  def edit
    redirect_to :root unless current_user && current_user.admin?
  end

  # POST /featured_events
  def create
    redirect_to :root unless current_user && current_user.admin?
    @featured_event = FeaturedEvent.new(featured_event_params)

    if @featured_event.save
      redirect_to @featured_event, notice: 'Featured event was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /featured_events/1
  def update
    redirect_to :root unless current_user && current_user.admin?
    if @featured_event.update(featured_event_params)
      redirect_to @featured_event, notice: 'Featured event was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /featured_events/1
  def destroy
    redirect_to :root unless current_user && current_user.admin?
    @featured_event.destroy
    redirect_to featured_events_url, notice: 'Featured event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_featured_event
      @featured_event = FeaturedEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def featured_event_params
      params.require(:featured_event).permit(:image_url, :event_url)
    end
end
