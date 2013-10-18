class Retreat < Event
  has_many :retreat_registrations

  def self.current
    self.last
  end
end
