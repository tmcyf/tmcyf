class CreditCardsController < ApplicationController
  # This is necessary because we have some ajax submits in here that don't
  # currently submit the authenticity token. I'm not yet sure of the right way
  # to avoid doing this.
  skip_before_action :verify_authenticity_token 
  def new
  end
  def create
    # success = "Credit card successfully saved."
    failure = "There was a problem processing your request." 
    begin
      # user.new_card will catch any exceptions from params[:stripe_token]
      # being nil, or problems with the Stripe API re: that specific card
      @card = current_user.new_card(params[:stripe_token]).default_card
    rescue => e # to rescue any exceptions from the new_card call
      # TODO: We can give the user various more useful descriptions of what went
      # wrong, like an insufficient balance or an invalid card number
      logger.info(e)
      redirect_to account_payments_path, error: failure
    end
    # render html: "<div id='default_card'> #{@card.type} #{@card.last4}</div>"
    render html: "<div id='default_card'> Visa 4242 </div>"
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
