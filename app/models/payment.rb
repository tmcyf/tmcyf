class Payment < ActiveRecord::Base
  belongs_to :payable, polymorphic: true
  has_many :charges
  after_create :set_active
  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  scope :active, -> { where(active: true) }

  def set_active
    self.active = true
    self.save!
 	end

end
