class AnswersCommentsController < ApplicationController
def create
  comentario = params[:comentario]
  answer_id = params[:answer_id]
  question_id = params[:question_id]

  if comentario != ""
    c = AnswerComment.new(contenido: comentario, question_id: answer_id, user_id: session[:user_id])
    if c.save == false
      flash[:message]="Error al guardar el comentario"
    end
  end
  redirect_to "#{questions_path}/#{question_id}"
end
