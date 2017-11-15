class DogsController < ApplicationController

  def create

      question_id = params[:question_id]

      question_comment_id = params[:question_comment_id]

      if params[:votoN_CQ]=="1"
      	voto=QuestionCommentVote.new(user_id: session[:user_id],question_comment_id: question_comment_id,tipo: false)
      end
      if params[:votoP_CQ]=="1"
      	voto=QuestionCommentVote.new(user_id: session[:user_id],question_comment_id: question_comment_id,tipo: true)
      end
      if voto.save
      	flash[:message]="Voto con exito"
      else
      	flash[:message]="Error en el voto"
  	  end
  	  redirect_to "#{questions_path}/#{question_id}"

  end



end
