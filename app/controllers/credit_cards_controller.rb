class CreditCardsController < ApplicationController
  def create
    # set credit card user to current_user
    # create a stripe::customer with the card
    # save stripe token 
  end

  def index
    @card_tokens = current_user.credit_cards
    @card_tokens.inject([]) do |token, array_of_digits|
      # grab the last four digits of the card token via the Stripe API 
      # and add it to the digits array
    end
  end

  def destroy
  end
end
