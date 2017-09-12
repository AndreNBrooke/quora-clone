post '/answers' do
	if logged_in?
		@input = add_user_id(params[:answer])
		@answer = Answer.new(@input)
		if @answer.save
			redirect to ("questions/#{@input["question_id"]}")
		else
			@error="You can only post one answer to question"
			redirect to("/")
		end
	else
		halt 401
	end
end

get '/users/:id/answers' do 
	@user = User.find_by(id: params[:id])
	@answers_list = Answer.where(user_id: @user.id).order(updated_at: :desc).flatten
	puts "[LOG] #{@answers_list.inspect}"
	erb :"answers/myanswers", :layout => false
end