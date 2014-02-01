class RetreatRegistration < ActiveRecord::Base
  belongs_to :user
  belongs_to :retreat
  # what other data is needed by retreat registrations?

  def paid?
    self.user.payments.any?{|p| p.event_id == self.retreat.id}
  end
end
