class Coach < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:login]
	
  attr_accessor :login

	# model association 
	has_many :players
	has_many :questions
	# validations
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :email
	validates_uniqueness_of :email, :message => "Email already taken"
	validates_presence_of :encrypted_password
	validates_presence_of :phone

	def generate_authentication_token!
    begin
        self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
	end
	
end
