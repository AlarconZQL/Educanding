class QuestionsController < ApplicationController

  def index
    $recargar=params
    @questions = filtered_questions
=begin
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
=end

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
    if params.has_key?(:answer_id) && @question.mejor_respuesta == nil
      @question.mejor_respuesta = params[:answer_id]
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
    @faculties = Faculty.all
  end

  def mejor
    question_id = @question.id
    if params[:answer_id] != nil && @question.mejor_respuesta == nil
      @question.mejor_respuesta = params[:answer_id]
    end
    redirect_to "#{questions_path}/#{question_id}"
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

  def filtered_questions
    result = Question.all
    user_id = session[:user_id]
    if user_id > 0
      fac_id = User.find(user_id).faculty_id  # obtengo el id de facultd del usuario
      if fac_id != 0
        result = result.where(faculty_id: fac_id) # si se tiene una facultad elegida filtro por esa facultad
      end
    end


    if params.has_key?(:busqueda)
      result = Question.all.where("contenido LIKE '%#{params[:busqueda]}%'") # si se esta buscando algo se filtra en base a eso
    
    end

    if params.has_key?(:facultad) 
      if params[:facultad] != 0
        if params.has_key?(:busqueda)
          result=result.where(faculty_id: params[:facultad])
         else
          result = Question.all.where(faculty_id: params[:facultad])
        end
      else
         result = result

      end
    end

    if result.count == 0
      flash[:message] = "No se han encontrado resultados para su busqueda"
    end
    result.order(created_at: :desc) # se ordenan las preguntas a mostrar por fecha de creacion de mas reciente a mas antigua
  end

end
