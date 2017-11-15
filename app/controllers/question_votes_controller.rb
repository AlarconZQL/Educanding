class QuestionsVotesController < ApplicationController
  def create


      question_id = params[:question_id]

      if params[:votoN]=="1"
        voto=QuestionVote.new(user_id: session[:user_id],question_id: question_id,tipo: false)
      end
      if params[:votoP]=="1"
        voto=QuestionVote.new(user_id: session[:user_id],question_id: question_id,tipo: true)
      end
      if voto.save
        flash[:message]="Voto con exito"
      else
        flash[:message]="Error en el voto"
      end
      redirect_to "#{questions_path}/#{question_id}"

  end
end
