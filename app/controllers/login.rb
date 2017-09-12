get '/' do
	redirect to '/questions'
end

get '/session/new' do
	@page_title = "Quora: Login"
	erb :"session/login"
end

post '/session' do
	@login = User.authenticate(params[:user]["email"], params[:user]["password"])
	case @login
	when "username_invalid"
		@error ="Invalid email entered"
		erb :"session/login"
	when "password_invalid"
		@error ="Invalid password entered for username #{params[:user]["email"]}"
		erb :"session/login"
	else
		session[:user_id] = @login
		redirect to "/"
	end
end

get '/session/loginform' do
	erb :"session/loginform", :layout => false
end

get '/session/reset' do
	session[:user_id] = nil
	redirect to "/"
end

delete '/session/destroy' do
	session[:user_id] = nil
	true
end