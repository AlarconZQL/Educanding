class AnswersController < ApplicationController
  def index

       @answer = Answer.find(params[:id])


    end

  def create
    question_id = params[:question_id]
    respuesta = params[:respuesta]

    if respuesta != ""
      r = Answer.new(contenido: respuesta, user_id: session[:user_id], question_id: question_id)
      if r.save == false
        flash[:message]="Error al guardar la respuesta"
      end
    else
      flash[:message]="Su respuesta debe tener contenido!"
    end
    redirect_to "#{questions_path}/#{question_id}"
  end

end
