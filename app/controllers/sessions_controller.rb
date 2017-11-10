class SessionsController < ApplicationController



  def index
  end

  def create

    if params[:email] != "" && params[:password] != ""

        # llamar al modelo y chequear los datos

        var = 1

        if var == 1

            session[:user_id] = 1

            redirect_to questions_index_path

        else

            #este es un mensaje que se guarda en la variable global flash, que sera mostrado
            #en la vista de iniciar sesion
            flash[:message] = "No existe usuario con tales datos"
            render :index

        end



    else

        #este es un mensaje que se guarda en la variable global flash, que sera mostrado
        #en la vista de iniciar sesion
        flash[:message] = "Debe completar bien los datos"
        render :index

    end



  end



  def new
  end



  def destroy

  session[:user_id] = 0

  redirect_to questions_index_path


  end



end
