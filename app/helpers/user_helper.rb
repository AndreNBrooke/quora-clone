helpers do
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by_id(session[:user_id]) 
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def check_submitted?(answer_list)
		return true if !logged_in?
			users_submitted = []
			answer_list.each { |t| users_submitted << t.user_id}
			return false if users_submitted.indclude?(current_user.id)
			return true
		end
	def add_user_id(hash)
		hash.merge({"user_id" => current_user.id})
	end

end
