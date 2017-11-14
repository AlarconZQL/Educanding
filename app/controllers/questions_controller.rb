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
  def show
        #Mostrar una pregunta, la de id del parametro
        @question=Question.find(params[:id])
        #Si el usuario que entra no es el que creo la pregunta el contador de visitas se actualiza+1
        if session[:user_id]!=@question.user_id 
          @question.num_visitas=@question.num_visitas+1
          @question.save
        end

  end

end
