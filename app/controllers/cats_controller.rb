class CatsController < ApplicationController
# Votos Respuestas
  def create

      question_id = params[:question_id]
      answer_id = params[:answer_id]

      if params[:votoN_A]=="1"
      	voto=AnswerVote.new(user_id: session[:user_id],answer_id: answer_id,tipo: false)
        modificacionPuntuacion=-1
      end
      if params[:votoP_A]=="1"
      	voto=AnswerVote.new(user_id: session[:user_id],answer_id: answer_id,tipo: true)
        modificacionPuntuacion=1
      end
      if voto.save
      	flash[:message]="Voto con exito"
        usuarioPunto= User.find(Answer.find(answer_id).user_id)
        render 'actualizarpuntosynivel'
      else
      	flash[:message]="Error en el voto"
  	  end
  	  redirect_to "#{questions_path}/#{question_id}"

  end



end
