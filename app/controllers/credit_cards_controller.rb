class CreditCardsController < ApplicationController
  def new
  end
  def create
    success = "Credit card successfully saved."
    failure = "There was a problem processing your request." 
    begin
      # user.new_card will catch any exceptions from params[:stripe_token]
      # being nil, or problems with the Stripe API re: that specific card
      current_user.new_card(params[:stripe_token])
      redirect_to account_payments_path, notice: success
    # need to rescue errors from the new_card call
    rescue => e
      # TODO: We can give the user various more useful descriptions of what went
      # wrong, like an insufficient balance or an invalid card number
      console.log(e)
      redirect_to account_payments_path, error: failure
    end
    format.js
  end

  def show
    begin
      current_user.credit_card
    rescue => e
      redirect_to account_payments_path, error: e
    end
  end

  def destroy
  end
end
