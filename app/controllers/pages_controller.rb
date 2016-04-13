class PagesController < ApplicationController

  def home
    url = 'http://www.heartlight.org/cgi-shl/todaysverse.cgi'
    data = Nokogiri::HTML(open(url))
    @votd = data.css(".well").children.first.text
    @votdref = data.css(".well").children.last.text

    @featured_event = FeaturedEvent.last
  end

  def about
  end

  def biblestudy
  end

  def privacy_policy
  end

end
