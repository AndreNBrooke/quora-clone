class User < ActiveRecord::Base
	validates :email, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Only valid email formats"} 
	validates :password, length: { minimum: 6, message: "password must be more than 6 characters in length" }
	validates :full_name, uniqueness: true, length: { maximum: 64}
	has_secure_password
	has_many :questions
	has_many :answers

	def self.authenticate(email, password)
		@user = User.find_by(email: email)
		if (@user != nil)
			return @user.id if @user.password == password
			return "Invalid Password" if @user.password != password
		else
			return "Invalid Username"
		end
	end


	def authenticate_login(email, password)
	
		if email == User.find_by_email(email).email && password_digest == User.find_by_email(email).password_digest
			return true
		else
			return false
		end
	end

end
