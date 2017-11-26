class LevelsController < ApplicationController

  def index
    @levels=Level.all
  end


    def create
      if params[:nombre]!="" && params[:puntos]#si no esta vacio
        if Level.where(nombre:params[:nombre]).count==0 && Level.where(puntos:params[:puntos]).count==0 #Si no existe el nivel
           level=Level.new(nombre: params[:nombre],puntos: params[:puntos]) #,activo: true
           if level.save#si se puede guardar
             redirect_to levels_index_path
             flash[:message] = "Se creo el nivel correctamente"


           else#Si no se guardo, sale el error
             #este es un mensaje que se guarda en la variable global flash
             flash[:message] = "No se pudo crear el nivel"
             redirect_to levels_index_path
           end
         else#Si la etiqueta existe
           #este es un mensaje que se guarda en la variable global flash
           flash[:message] = "El nivel ya existe"
           redirect_to labels_index_path
         end
      else #los datos no so completaron
      #este es un mensaje que se guarda en la variable global flash
      flash[:message] = "Debe completar los datos"
      redirect_to labels_index_path
    end


    end


    def update
      level=Level.find(params[:level_id])
      level.nombre=params[:nombre]
      level.puntos=params[:puntos]

      if Level.where(nombre:params[:nombre]).count==0 && Level.where(puntos:params[:puntos]).count==0 #Si no existe el nivel
        level.save
        flash[:message] = "El nivel se actualizo"
      else   #Si el nivel  existe
        #este es un mensaje que se guarda en la variable global flash
        flash[:message] = "El nivel ya existe"
      end


      redirect_to levels_index_path
    end

    def delete
      if session[:user_id]!=0 && User.find(session[:user_id]).admin
        level=Level.find(params[:format])
        level.activo=false
        level.save
        redirect_to levels_index_path
      end
    end




end
