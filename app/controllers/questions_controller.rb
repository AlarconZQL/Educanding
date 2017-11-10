class QuestionsController < ApplicationController
  def index

    if session[:user_id] != 0

        # ver si el usuario tiene seleccionado una facultad, y entonces seleccionar preguntas
        # de esa facultad

        questions = Question.all


    else

        # iniciar preguntas

        questions = Question.all


    end




  end
end
