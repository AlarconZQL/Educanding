class CowsController < ApplicationController
# Votos Comentario Respuestas
  def create

      question_id = params[:question_id]

      answer_comment_id = params[:answer_comment_id]

      if params[:votoN_CA]=="1"
      	voto=AnswerCommentVote.new(user_id: session[:user_id],answer_comment_id: answer_comment_id,tipo: false)
        @modificacionPuntuacion=-1
      end
      if params[:votoP_CA]=="1"
      	voto=AnswerCommentVote.new(user_id: session[:user_id],answer_comment_id: answer_comment_id,tipo: true)
        @modificacionPuntuacion=1
      end
      if voto.save
      	flash[:message]="Voto con exito"
        @usuarioPunto= User.find(AnswerComment.find(answer_comment_id).user_id)
        actualizarpuntosynivel
      else
      	flash[:message]="Error en el voto"
  	  end
  	  redirect_to "#{questions_path}/#{question_id}"

  end
  def actualizarpuntosynivel

    if @usuarioPunto.puntos+@modificacionPuntuacion >= 0
      @usuarioPunto.puntos=@usuarioPunto.puntos+@modificacionPuntuacion
      if @usuarioPunto.save
        niveles = Level.all.where(activo: true).order(puntos: :DESC) # ordena los niveles de mayor a menor puntuacion en un arreglo
        i = 0
        while i<niveles.size && @usuarioPunto.puntos<niveles[i].puntos do # avanzo a un nivel de menor rango siempre que mis puntos sean menores que los del actual
           i = i+1
        end # al salir del lazo 'i' me indica la posicion del nivel que me corresponda en el arreglo
        if @usuarioPunto.level_id != niveles[i].id # actualizo el nivel si es distinto de mi nivel actual
          @usuarioPunto.level_id = niveles[i].id
          if @usuarioPunto.save == false
            flash[:message]="Ocurrio un error al actualizar un nivel"
          end
        end
      end
    end
  end

end
