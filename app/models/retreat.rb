class Retreat < Event
  require 'csv'
  has_many :retreat_registrations

  def self.current
    self.last
  end

  def to_csv
    CSV.generate do |csv|
      column_names = RetreatRegistration.column_names
      column_names << "Paid?"
      csv << column_names
      self.retreat_registrations.each do |registration|
        values = registration.attributes.values_at(*column_names)
        values << registration.paid?
        csv << values
      end
    end
  end
end
