class CreditCardsController < ApplicationController
  def new
  end
  def create
    success = "Credit card successfully saved."
    failure = "There was a problem processing your request." 
    # set credit card user to current_user
    # create a stripe::customer with the card
    # save stripe token 
    # need a failure mechanism for the stripe customer creation stuff
    # 
    @credit_card = current_user.credit_card.build
    if params[:stripe_token]
      # TODO: can I catch an error from this request?
      @user.add_card(params[:stripe_token])
      redirect_to account_payments_path, notice: success
    else
      redirect_to account_payments_path, error: failure
    end
  end

  # TODO: make this return json
  def index
    render json: current_user.credit_card_list
  end

  def destroy
  end
end
