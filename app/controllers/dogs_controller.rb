class DogsController < ApplicationController
# Votos Comentario Preguntas
  def create

      question_id = params[:question_id]

      question_comment_id = params[:question_comment_id]

      if params[:votoN_CQ]=="1"
      	voto=QuestionCommentVote.new(user_id: session[:user_id],question_comment_id: question_comment_id,tipo: false)
        modificacionPuntuacion=-1
      end
      if params[:votoP_CQ]=="1"
      	voto=QuestionCommentVote.new(user_id: session[:user_id],question_comment_id: question_comment_id,tipo: true)
        modificacionPuntuacion=1
      end
      if voto.save
      	flash[:message]="Voto con exito"
        usuarioPunto= User.find(QuestionComment.find(question_comment_id).user_id)
        usuarioPunto.puntos=usuarioPunto.puntos+modificacionPuntuacion
        usuarioPunto.save
      else
      	flash[:message]="Error en el voto"
  	  end
  	  redirect_to "#{questions_path}/#{question_id}"

  end

end
