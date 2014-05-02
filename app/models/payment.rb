class Payment < ActiveRecord::Base
  belongs_to :payable, polymorphic: true
  has_many :charges
end
