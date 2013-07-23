class PagesController < ApplicationController
	before_filter :authenticate_user!, :except => [:home, :about, :about_biblestudies, :about_tribes, :about_service, :about_socials, :about_officers, :about_contact, :events, :biblestudy, :account]

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
