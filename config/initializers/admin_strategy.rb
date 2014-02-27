module Devise
  module Strategies
    class Admin < Base
      def authenticate!
        u = User.find_by(id: session[:user_id])
        !(u.nil?) && u.admin? ? fail!("User not admin.") : sucess!(u)
      end
    end
  end
end

config.warden do |manager|
  manager.strategies.add(:admin, Devise::Strategies::Admin)
end
