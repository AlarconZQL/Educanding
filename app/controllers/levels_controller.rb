class LevelsController < ApplicationController

  def index
    @levels=Level.all
  end


  def create

    if params[:nombre]!="" && params[:puntos]!=nil#si no esta vacio
      if params[:puntos].to_i >= 0
        if Level.where(nombre:params[:nombre]).count==0 && Level.where(puntos:params[:puntos]).count==0 #Si no existe el nivel
          level=Level.new(nombre: params[:nombre],puntos: params[:puntos],activo: true)
          if level.save#si se puede guardar
            actualizarpuntosynivel
            redirect_to levels_index_path
            flash[:message] = "Se creo el nivel correctamente"
          else#Si no se guardo, sale el error
            #este es un mensaje que se guarda en la variable global flash
            flash[:message] = "No se pudo crear el nivel"
            redirect_to levels_index_path
          end
        else#Si el nivel ya existe
         #este es un mensaje que se guarda en la variable global flash
         flash[:message] = "El nivel ya existe"
         redirect_to levels_index_path
        end
      else
      #este es un mensaje que se guarda en la variable global flash
      flash[:message] = "Los puntos del nivel deben ser positivos"
      redirect_to levels_index_path
      end
    else #los datos no so completaron
    #este es un mensaje que se guarda en la variable global flash
    flash[:message] = "Debe completar los datos"
    redirect_to levels_index_path
    end



    end


    def update
      level=Level.find(params[:level_id])
      level.nombre=params[:nombre]
      level.puntos=params[:puntos]
      if level.puntos >= 0
        if Level.where(nombre:params[:nombre]).count==0 && Level.where(puntos:params[:puntos]).count==0 #Si no existe el nivel
          level.save
          actualizarpuntosynivel
          flash[:message] = "El nivel se actualizo"
        else   #Si el nivel  existe
          #este es un mensaje que se guarda en la variable global flash
          flash[:message] = "El nivel ya existe"
        end
      else   #Si el nivel  existe
        #este es un mensaje que se guarda en la variable global flash
        flash[:message] = "Los puntos del nivel deben ser positivos"
      end


      redirect_to levels_index_path
    end

    def delete
      if session[:user_id]!=0 && User.find(session[:user_id]).admin
        level=Level.find(params[:format])
        level.activo=false
        level.save
        actualizarpuntosynivel
        redirect_to levels_index_path
      end
    end


    def actualizarpuntosynivel

    niveles = Level.all.where(activo: true).order(created_at: :DESC) # ordena los niveles de mayor a menor puntuacion en un arreglo

    User.all.each do |user|
      i = 0
      while user.puntos < niveles[i].puntos && i<niveles.size do # avanzo a un nivel de menor rango siempre que mis puntos sean menores que los del actual
         i = i+1
      end # al salir del lazo 'i' me indica la posicion del nivel que me corresponda en el arreglo
      if user.level_id != niveles[i].id # actualizo el nivel si es distinto de mi nivel actual
        user.level_id = niveles[i].id
        if user.save == false
          flash[:message]="Ocurrio un error al actualizar un nivel"
        end
      end
    end

    end




end
