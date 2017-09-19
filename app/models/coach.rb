class Coach < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
end
