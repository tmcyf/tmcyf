class PagesController < ApplicationController
	before_filter :authenticate_user!, :except => [:home, :about, :events, :biblestudy, :account]

	def home		
	end

  def about
  end

  def events
  end

  def biblestudy
  end

  def account
  end
end
