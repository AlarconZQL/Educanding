class CarsController < ApplicationController
# Votos Preguntas
  def create


      question_id = params[:question_id]

      if params[:votoN]=="1"
      	voto=QuestionVote.new(user_id: session[:user_id],question_id: question_id,tipo: false)
        modificacionPuntuacion=-1
      end
      if params[:votoP]=="1"
      	voto=QuestionVote.new(user_id: session[:user_id],question_id: question_id,tipo: true)
        modificacionPuntuacion=1
      end
      if voto.save
      	flash[:message]="Voto con exito"
        usuarioPunto= User.find(Question.find(question_id).user_id)
        usuarioPunto.puntos=usuarioPunto.puntos+modificacionPuntuacion
        usuarioPunto.save
      else
      	flash[:message]="Error en el voto"
  	  end
  	  redirect_to "#{questions_path}/#{question_id}"

  end

end
