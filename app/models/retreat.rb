class Retreat < Event
  require 'csv'
  has_many :retreat_registrations

  def self.current
    self.last
  end

  def to_csv
    CSV.generate do |csv|
      column_names = self.retreat_registrations.first.attributes.keys
      csv << (column_names.concat ["Paid?", "Email"])
      self.retreat_registrations.each do |registration|
        values = registration.attributes.values_at(*(RetreatRegistration.column_names))
        values << registration.paid?
        values << registration.user.email
        csv << values
      end
    end
  end
end
