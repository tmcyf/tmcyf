module Payable
  extend ActiveSupport::Concern
  included do
    has_one :payment, as: :payable
  end
  
end
