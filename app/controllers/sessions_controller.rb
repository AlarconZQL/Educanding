class SessionsController < ApplicationController



  def index
  end

  def create

    if params[:email] != "" && params[:password] != ""

        # llamar al modelo y chequear los datos
       
        if User.where(mail:params[:email]).count==1
          if User.where(mail:params[:email]).first.pass==params[:password]
            var = 1
          else
            var = -1
          end
        else
          var = 0                              
        end

        if var == 1 #Se inicia la session

            session[:user_id] = User.where(mail:params[:email]).first.id

            redirect_to root_path

        else
          if var == -1 #Contraseña incorrecta
            #este es un mensaje que se guarda en la variable global flash, que sera mostrado
            #en la vista de iniciar sesion
            flash[:message] = "Contraseña Incorrecta"
            redirect_to sessions_index_path

          else #Correo incorrecto
            #este es un mensaje que se guarda en la variable global flash, que sera mostrado
            #en la vista de iniciar sesion
            flash[:message] = "No existe usuario con tales datos"
            redirect_to sessions_index_path
          end
        end

    else

        #este es un mensaje que se guarda en la variable global flash, que sera mostrado
        #en la vista de iniciar sesion
        flash[:message] = "Debe completar bien los datos"
        redirect_to sessions_index_path

    end



  end



  def new
  end



  def destroy

  session[:user_id] = 0

  redirect_to root_path


  end



end
