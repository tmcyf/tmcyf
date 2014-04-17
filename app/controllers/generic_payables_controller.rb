class GenericPayablesController < ApplicationController
  before_action :set_generic_payable, only: [:show, :edit, :update, :destroy]

  # GET /generic_payables
  def index
    @generic_payables = GenericPayable.all
  end

  # GET /generic_payables/1
  def show
  end

  # GET /generic_payables/new
  def new
    @generic_payable = GenericPayable.new
  end

  # GET /generic_payables/1/edit
  def edit
  end

  # POST /generic_payables
  def create
    @generic_payable = GenericPayable.new(generic_payable_params)

    if @generic_payable.save
      redirect_to @generic_payable, notice: 'Generic payable was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /generic_payables/1
  def update
    if @generic_payable.update(generic_payable_params)
      redirect_to @generic_payable, notice: 'Generic payable was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /generic_payables/1
  def destroy
    @generic_payable.destroy
    redirect_to generic_payables_url, notice: 'Generic payable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_generic_payable
      @generic_payable = GenericPayable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def generic_payable_params
      params.require(:generic_payable).permit(:description, :amount)
    end
end
