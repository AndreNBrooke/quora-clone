get '/users/new' do
	@page_title = "Quora: Registration"
	erb :"users/new"
end

get '/users/:id' do
	@page_title = "Quora: User Profile"
	erb :"users/profile"
end

post '/users' do 
	@user = User.new(params[:user])

	if @user.save
		session[:user_id] = @user.id
		redirect to '/'
	else 
		@error = @user.errors.full_messages[0]
		erb :"users/new"
	end
end

