class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable
  has_many :credit_cards
  has_many :payments, through: :credit_cards
  
  def fullname
  	self.fname + self.lname
  end

  def address
  	self.line1 + self.city + self.state + self.zip  	
  end
end
