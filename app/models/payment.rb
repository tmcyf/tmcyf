class Payment < ActiveRecord::Base
  belongs_to :payable, polymorphic: true
  has_many :charges

  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
end
