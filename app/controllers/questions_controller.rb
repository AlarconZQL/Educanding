class QuestionsController < ApplicationController

  def index
    @questions = Question.all

    if session[:user_id] != 0
      fac = User.find(session[:user_id]).faculty_id
      if fac != Faculty.where(nombre: "Ninguna")
        @questions = @questions.where(faculty_id: fac).order(created_at: :desc)
      end
      if @resultado != nil
        if @resultado.count != 0
          if fac != Faculty.where(nombre: "Ninguna")
            @questions = @resultado.where(faculty_id: fac)
          end
            @questions = @resultado.order(created_at: :desc)
        else
          flash [:message]
        end
      end
    end

    @faculties = Faculty.all
    @answers = Answer.all
    @labels = Label.all
    @directions = Direction.all
    @users = User.all
    @questionvotes = QuestionVote.all


    flash[:auxIngReg] = nil #se pone en nula para que aparezca el cartel de ingresar/registrarse


  end

  def show
        #Mostrar una pregunta, la de id del parametro
        @question=Question.find(params[:id])
        #Si el usuario que entra no es el que creo la pregunta el contador de visitas se actualiza+1
        if session[:user_id]!=@question.user_id
          @question.num_visitas=@question.num_visitas+1
          @question.save
        end
        @answers = Answer.all
        @users = User.all
        @questionvotes = QuestionVote.all
        @questioncomments = QuestionComment.all
        @questioncommentvotes = QuestionCommentVote.all
        @answervotes = AnswerVote.all
        @answercomments = AnswerComment.all
        @answercommentvotes = AnswerCommentVote.all
        @questionlabel = QuestionLabel.all
        @labels = Label.all
  end

  def new
     if session[:user_id]!=0
        @labels = Label.all
    else
       redirect_to root_path
    end
  end

  def create

    $recargar=params#Si llega a fallar, en $recargar, queda todos los parametros del formulario, para el rellenado
    etiquetas = params[:etiqueta]
    descripcion = params[:descripcion]
    if etiquetas != nil
      if etiquetas.size >= 1 && etiquetas.size <= 5
        if params[:pregunta]!=""
          pregunta=Question.new(num_visitas:0, contenido:params[:pregunta], desc:descripcion, user_id: session[:user_id], faculty_id: User.find(session[:user_id]).faculty_id)
          #hay que guardar la pregunta
          if pregunta.save
             for i in (0..etiquetas.size-1)
              etiquetasPregunta=QuestionLabel.new(question_id:pregunta.id,label_id:etiquetas[i])
              if !etiquetasPregunta.save
                 break;
              end
              end
              if i !=etiquetas.size-1
                pregunta.destroy
                flash[:message] = "Error no se creo la pregunta"
              else
             flash[:message] = "Pregunta Creada"
             $recargar=nil
           end
          else
             flash[:message] = "Error no se creo la pregunta"
          end
        else
          flash[:message] = "Debe ingresar una pregunta"
        end
      else
        flash[:message] = "Debe seleccionar entre 1 y 5 etiquetas"
      end
    else
      flash[:message] = "Debe seleccionar entre 1 y 5 etiquetas"
    end

     @labels = Label.all

    if flash[:message] != "Pregunta Creada"
      render :new
    else
      redirect_to root_path
    end

  end

  def search
    contenido = params[:contenido]
    @resultado = []
    i = 0
    Question.all.each do |preg|
      if preg.contenido.include?(contenido)
        @resultado [i] = preg
        i = i + 1
      end
    end

    redirect_to index_path
  end

end
