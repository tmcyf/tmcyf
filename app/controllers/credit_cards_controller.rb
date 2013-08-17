class CreditCardsController < ApplicationController
  def new
  end
  def create
    # set credit card user to current_user
    # create a stripe::customer with the card
    # save stripe token 
    @user = current_user
  end

  def index
    @card_tokens = current_user.credit_cards
    @card_tokens.collect do |token|
      # grab the last four digits of the card token via the Stripe API 
      # and return it to add it to the returned array
    end
  end

  def destroy
  end
end
