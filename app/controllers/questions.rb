get '/questions' do 
	@page_title = "Quora!"
	@list_title = "Most Recent Questions"
	@list = Question.all.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 3)
	erb :"questions/all"
end

get '/questions/new' do
	@page_title = "Ask a question"
	erb :"questions/new"
end

get '/questions/:id' do	
	@question = Question.find(params[:id])
	@answers_list = Answer.where(question_id: params[:id]).order(updated_at: :desc)
	@page_title = "Quora: #{@question.title}"
	erb :"questions/view"
end

post '/questions' do
	if logged_in?
		@input = add_user_id(params[:question])
	else
		@input = params[:question]
	end
	@question_split = @input["description"].split("\n", 2)
	@input["title"] = @question_split[0]
	@input["description"] = @question_split[1].gsub!(/\r\n?/, "\n") if @question_split.length > 1
	@question = Question.new(@input)
	if @question.save
		redirect to ('/')
	else
		@error = @question.errors.full_messages[0]
		erb :"questions/new"
	end
end

get '/users/:id/questions' do
	@user = User.find_by(id: params[:id])
	
	@questions_list = Question.where(user_id: @user.id).order(updated_at: :desc)
	return erb :"questions/myquestions", :layout => false
end