class LevelsController < ApplicationController

  def index
    if Usuario.new(session[:user_id]).getFuncionalidad("Administrar Niveles")
    @levels=Level.all
    else
      flash[:message]="No tiene acceso a la ruta de recien"
      redirect_to root_path
    end
  end


  def create

    funcionalidades = params[:funcionalidades]

    if funcionalidades != nil
      if funcionalidades.size >= 1

        if params[:nombre]!="" && params[:puntos]!=nil#si no esta vacio
          nombreFormato=params[:nombre].capitalize
          if params[:puntos].to_i >= 0
            if Level.where(nombre:nombreFormato).count==0 && Level.where(puntos:params[:puntos]).count==0 #Si no existe el nivel
              level=Level.new(nombre: nombreFormato,puntos: params[:puntos])
              if level.save#si se puede guardar

                i = 0
                while i < funcionalidades.size do # avanzo a un nivel de menor rango siempre que mis puntos sean menores que los del actual
                  levelFunctionality=LevelFunctionality.new(level_id:level.id,functionality_id:funcionalidades[i])
                  levelFunctionality.save
                  i = i+1
                end

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

      else
      flash[:message] = "Debe elegir funcionalidades"
      redirect_to levels_index_path
      end
    else
    flash[:message] = "Debe elegir funcionalidades"
    redirect_to levels_index_path
    end
  end


    def update
      level=Level.find(params[:level_id])
      if level.puntos >1#Si el nivel no es el inicial, lo edito
        level.nombre=params[:nombre].capitalize
        level.puntos=params[:puntos]
        if level.puntos >= 0
          if Level.where(nombre:params[:nombre]).count==0 || Level.where(nombre:params[:nombre]).first.id==level.id #Si no existe el nombre, o es el nivel que se quiere moodificar
            if Level.where(puntos:params[:puntos]).count==0 || Level.where(puntos:params[:puntos]).first.id==level.id #Si no existe el puntaje, o es el nivel que se quiere moodificar
              level.save
              actualizarpuntosynivel
              flash[:message] = "El nivel se actualizo"
            else   #Si el puntaje existe
               flash[:message] = "El puntaje ya existe"
            end
          else #Si el nivel existe
              flash[:message] = "El nivel ya existe"
          end
        else   #Si el nivel  existe
          #este es un mensaje que se guarda en la variable global flash
          flash[:message] = "Los puntos del nivel deben ser positivos"
        end
      end
      redirect_to levels_index_path
    end

    def delete
      if session[:user_id]!=0 && User.find(session[:user_id]).admin
        level=Level.find(params[:format])
        if level.puntos >1 #Si el nivel no es el inicial, lo borro
          level.destroy#borrado fisico
          actualizarpuntosynivel
        end
        redirect_to levels_index_path
      end
    end


    def actualizarpuntosynivel

    niveles = Level.all.order(puntos: :DESC) # ordena los niveles de mayor a menor puntuacion en un arreglo

    User.all.each do |user|
      i = 0
      while i<niveles.size && user.puntos < niveles[i].puntos do # avanzo a un nivel de menor rango siempre que mis puntos sean menores que los del actual
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
