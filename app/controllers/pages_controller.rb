class PagesController < ApplicationController

  def home
    url = 'http://www.heartlight.org/cgi-shl/todaysverse.cgi'
    data = Nokogiri::HTML(open(url))
    @votd = data.at_css(".todays-verse-verse").text
    @votdref = data.at_css(".todays-verse-ref").text

    @featured_events = FeaturedEvent.last
  end

  def about
  end

  def biblestudy
  end

  def privacy_policy
  end

end
