class SermonsController < ApplicationController
  before_action :set_sermon, only: [:show, :edit, :update, :destroy]

  # GET /sermons
  def index
    @sermons = Sermon.all
  end

  # GET /sermons/1
  def show
  end

  # GET /sermons/new
  def new
    redirect_to :root unless current_user && current_user.admin?
    @sermon = Sermon.new
  end

  # GET /sermons/1/edit
  def edit
    redirect_to :root unless current_user && current_user.admin?
  end

  # POST /sermons
  def create
    redirect_to :root unless current_user && current_user.admin?
    @sermon = Sermon.new(sermon_params)

    if @sermon.save
      redirect_to @sermon, notice: 'Sermon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sermons/1
  def update
    redirect_to :root unless current_user && current_user.admin?
    if @sermon.update(sermon_params)
      redirect_to @sermon, notice: 'Sermon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sermons/1
  def destroy
    redirect_to :root unless current_user && current_user.admin?
    @sermon.destroy
    redirect_to sermons_url, notice: 'Sermon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sermon
      @sermon = Sermon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sermon_params
      params.require(:sermon).permit(:title, :notes, :audio)
    end
end
