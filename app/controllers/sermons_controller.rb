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
    @sermon = Sermon.new
  end

  # GET /sermons/1/edit
  def edit
  end

  # POST /sermons
  def create
    @sermon = Sermon.new(sermon_params)

    if @sermon.save
      redirect_to @sermon, notice: 'Sermon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sermons/1
  def update
    if @sermon.update(sermon_params)
      redirect_to @sermon, notice: 'Sermon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sermons/1
  def destroy
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
