class QuestionsVotesController < ApplicationController
  def create
  	if param[:tipo]
  		voto=QuestionsVotes.new(user_id:session[:user_id],question_id:param[:question_id],tipo:param[:tipo])
  	else
  		voto=QuestionsVotes.new(user_id:session[:user_id],question_id:param[:question_id],tipo:param[:tipo])
  	end
  	if voto.save
      redirect_to root_path

  	else
  		redirect_to root_path
  	end

  end
end
