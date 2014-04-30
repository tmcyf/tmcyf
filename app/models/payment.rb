class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :payable, polymorphic: true
end
