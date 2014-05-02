class IcsGenerator
  require 'icalendar'

  include Icalendar

  def self.ics_for(event)
    cal = Calendar.new
    cal.event do |e|
      e.summary = event.title
      e.dtstart = event.startdt.strftime("%Y%m%dT%H%M%S")
      e.dtend = event.enddt.strftime("%Y%m%dT%H%M%S")
      e.description = event.body
      e.location = event.location
    end
    cal.to_ical
  end
end
