class UsersController < ApplicationController
  def index
    @faculties = Faculty.all
    @directions = Direction.all
    flash[:auxIngReg] = "1"
  end
  def create
    $recargar=params#Si llega a fallar, en $recargar, queda todos los parametros del formulario, para el rellenado
    if params[:nombre] != "" && params[:apellido] != "" && params[:email] != "" && params[:password] != "" && params[:password2] != ""

        # llamar al modelo y chequear los datos
        if User.where(mail:params[:email]).count == 0#Se pregunta si el mail no existe
       		if params[:password] == params[:password2]#Se pregunta si las contraseñas son iguales
       			@usuario= User.create(nombre: params[:nombre],apellido: params[:apellido],mail: params[:email],pass: params[:password],puntos:0,level_id: Level.where(nombre:"Iniciado").first.id,activo:true)
       			if params[:facultad_nombre]!="0"
              @usuario.faculty_id = Faculty.where(nombre:params[:facultad_nombre]).first.id
            else
              @usuario.faculty_id = 0
            end
            if @usuario.save   #Guarda el usuario
                flash[:auxIngReg] = nil #se pone en nula para que aparezca el cartel de ingresar/registrarse
        	    	redirect_to root_path
        		else#Si no se guardo, sale el error
        			#este es un mensaje que se guarda en la variable global flash
        	    	flash[:message] = "No se pudo crear la cuenta"
        			redirect_to users_index_path
        		end
        	else#Ingreso contraseñas distintas
    			#este es un mensaje que se guarda en la variable global flash
        		flash[:message] = "Las contraseñas son diferentes, intente otra vez"
        		redirect_to users_index_path
        	end
        else#Este mail ya esta registrado
    		#este es un mensaje que se guarda en la variable global flash
        	flash[:message] = "Este mail ya esta registrado, intente con otro"
        	redirect_to users_index_path
        end
    else#No completo todos los campos bien
        #este es un mensaje que se guarda en la variable global flash
        flash[:message] = "Debe completar bien los datos"
        redirect_to users_index_path
    end
  end

  def show
    if params[:format]!=nil
      @user = User.find(params[:format])
    else
      @user = User.find(session[:user_id])
    end
    
    @userPerfil = User.find(session[:user_id])

    @preguntas = Question.all.where(user_id: @user.id)
    @answers = Answer.all
    @niveles = Level.all
    @facultades = Faculty.all
    @direcciones = Direction.all
    @questionvotes = QuestionVote.all
  end

  def update
    user = User.find(params[:user_id])
    exito_guardar = true
    guardados = 0
    if params[:nombre] != ""
      user.nombre = params[:nombre]
      if user.save == false
        flash[:message] = "Fallo al actualizar nombre"
        exito_guardar = false
      else
        guardados = guardados + 1
      end
    end
    if params[:apellido] != ""
      user.apellido = params[:apellido]
      if user.save == false
        flash[:message] = "Fallo al actualizar apellido"
        exito_guardar = false
      else
        guardados = guardados + 1
      end
    end
    if params[:facultad_id] != "-" && Faculty.all.where(id:params[:facultad_id]).count != 0
      user.faculty_id = params[:facultad_id]
      if user.save == false
        flash[:message] = "Fallo al actualizar facultad"
        exito_guardar = false
      else
        guardados = guardados + 1
      end
    end
    if params[:email] != ""
      if User.all.where(mail:params[:email]).count == 0
        user.mail = params[:email]
        if user.save == false
          flash[:message] = "Fallo al actualizar email"
          exito_guardar = false
        else
          guardados = guardados + 1
        end
      else
        flash[:message] = "El mail elegido ya esta registrado"
        exito_guardar = false
      end
    end
    if guardados > 0
      flash[:message] = "Sus datos se han modificado con exito!"
    end

    redirect_to users_show_path
  end

end
