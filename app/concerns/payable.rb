module Payable
  extend ActiveSupport::Concern
  included do
    has_one :payment, as: :payable
    accepts_nested_attributes_for :payment
  end
  
end
