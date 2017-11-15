class UsersController < ApplicationController
  def index
    @faculties = Faculty.all
    @directions = Direction.all
  end
  def create

    if params[:nombre] != "" && params[:apellido] != "" && params[:email] != "" && params[:password] != "" && params[:password2] != ""

        # llamar al modelo y chequear los datos
        if User.where(mail:params[:email]).count == 0#Se pregunta si el mail no existe
       		if params[:password] == params[:password2]#Se pregunta si las contraseñas son iguales
       			@usuario= User.create(nombre: params[:nombre],apellido: params[:apellido],mail: params[:email],pass: params[:password],puntos:0,faculty_id:Faculty.where(nombre:params[:facultad_nombre]).first.id,level_id: Level.where(nombre:"Iniciado").first.id)
       			if @usuario.save   #Guarda el usuario    			
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
end
