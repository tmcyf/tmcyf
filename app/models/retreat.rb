class Retreat < Event
  require 'csv'
  has_many :retreat_registrations

  def self.current
    self.last
  end

  def to_csv
    CSV.generate do |csv|
      column_names = RetreatRegistration.column_names
      csv << column_names
      self.retreat_registrations.each do |registration|
        csv << registration.attributes.values_at(*column_names)
      end
    end
  end
end
