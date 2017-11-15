class QuestionsCommentsController < ApplicationController
  def index
  end

  def create
    comentario = params[:comentario]
    question_id = params[:question_id]

    if comentario != ""
      c = QuestionComment.new(contenido: comentario, question_id: question_id, user_id: session[:user_id])
      if c.save == false
        flash[:message]="Error al guardar el comentario"
      end
    else
      flash[:message]="Su comentario debe tener contenido!"
    end
    redirect_to "#{questions_path}/#{question_id}"
  end

  def show
  end

  def destroy
  end
end
