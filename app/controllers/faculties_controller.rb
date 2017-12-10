class FacultiesController < ApplicationController
  def index
    if Usuario.new(session[:user_id]).getFuncionalidad("Administrar Facultades")
      @faculties=Faculty.all
      @directions=Direction.all
    else
      flash[:message]="No tiene acceso a la ruta de recien"
      redirect_to root_path
    end
  end

  def create

    if params[:nombre]!="" && params[:ciudad]!="" && params[:direccion]!="" #si no esta vacio

      nombre=params[:nombre].capitalize
      ciudad=params[:ciudad].capitalize
      calle=params[:direccion].capitalize

      if Faculty.where(nombre:nombre).count==0#Si no existe la facultad

        if Direction.where(ciudad:ciudad,calle:calle).count==0#Si no existe la facultad

          direccion = Direction.new(ciudad:ciudad,calle:calle)
          if direccion.save
            facultad=Faculty.new(nombre: nombre,direction_id:direccion.id,activo:true)
            if facultad.save#si se puede guardar

              flash[:messageOk] = true
              flash[:message] = "Facultad creada"
            else#Si no se guardo, sale el error
              #este es un mensaje que se guarda en la variable global flash
              flash[:message] = "No se pudo crear la facultad"
              flash[:messageError] = true

            end
          else#Si no se guardo, sale el error
            #este es un mensaje que se guarda en la variable global flash
            flash[:message] = "No se pudo crear la facultdad"
            flash[:messageError] = true

          end

        else #Si la direccion existe
          flash[:message] = "La direccion ingresada ya existe"
          flash[:messageError] = true

        end

      else#Si la facultad existe

        if Faculty.where(nombre:nombre).first.activo==true
          #este es un mensaje que se guarda en la variable global flash
          flash[:message] = "La facultad ya existe"
          flash[:messageError] = false
        else

          if Direction.where(ciudad:ciudad,calle:calle).count==0#Si no existe la facultad

            facultad=Faculty.where(nombre:nombre).first
            facultad.activo = true
            if facultad.save#Si no se guardo, sale el error
              direccion = Direction.where(id:facultad.direction_id).first
              direccion.ciudad = ciudad
              direccion.calle = calle
              direccion.activo = true
              if direccion.save
                flash[:message] = "Facultdad creada"
                flash[:messageOk] = true
                redirect_to faculties_index_path
              else
                flash[:message] = "No se pudo crear la facultad"
                flash[:messageError] = true
              end
            else
              flash[:message] = "No se pudo crear la facultad"
              flash[:messageError] = true
            end

          else #Si  la facultad  existe

            direccion = Direction.where(ciudad:ciudad,calle:calle).first
            facultad=Faculty.where(nombre:nombre,ciudad:ciudad).first

            if direccion.id == facultad.direction_id
              facultad.activo = true
              direccion.activo = true
              if facultad.save && direccion.save #Si no se guardo, sale el error
                flash[:message] = "Facultad creada"
                flash[:messageOk] = true
              else
                flash[:message] = "No se pudo crear la facultad"
                flash[:messageError] = true
              end
            else
              flash[:message] = "la direccion ya existe"
              flash[:messageError] = true
            end

            flash[:message] = "la direccion ya existe"
            flash[:messageError] = true

          end

        end
      end

    else
      flash[:message] = "Debe completar los campos"
      flash[:messageError] = true
    end

    redirect_to faculties_index_path


  end



  def show
    @faculties=Faculty.all
    @directions=Direction.all
    order=[]# Arreglo que contiene cada elemento, en la primer posicion la cantidad de preguntas que tiene una facutad, y como segundo el id de la facultad
    i=0
    Faculty.all.each do |facultad|
      order[i]=[Question.where(faculty_id:facultad.id).count,facultad.id]
      i=i+1
    end
    @mayores=order.sort.reverse
  end

  def destroy
  end

  def update

    if params[:nombre]!="" && params[:ciudad]!="" && params[:direccion]!="" #si no esta vacio

      nombre=params[:nombre].capitalize
      ciudad=params[:ciudad].capitalize
      calle=params[:direccion].capitalize

      if Faculty.where(nombre:nombre).count==0#Si no existe la facultad

        if Direction.where(ciudad:ciudad,calle:calle).count==0#Si no existe la facultad

          facultad = Faculty.where(id:params[:faculty_id]).first
          facultad.nombre = nombre
          direccion = Direction.where(id:facultad.id).first
          direccion.calle=calle
          direccion.ciudad=ciudad
          if facultad.save && direccion.save
            flash[:message] = "Facultad modificada"
            flash[:messageOk] = true
          else
            flash[:message] = "No se pudo modificar la facultad"
            flash[:messageError] = true
          end

        else

          facultad = Faculty.where(id:params[:faculty_id]).first
          direccion = Direction.where(id:facultad.id).first

          if Direction.where(ciudad:ciudad,calle:calle).first.id == direccion.id
            facultad.nombre = nombre
            if facultad.save
              flash[:message] = "Facultad modificada"
              flash[:messageOk] = true
            else
              flash[:message] = "No se pudo modificar la facultad"
              flash[:messageError] = true
            end
          else
            flash[:message] = "La direccion ingresada corresponde a otro facultad"
            flash[:messageError] = true
          end


        end

      else

        facultad = Faculty.where(id:params[:faculty_id]).first
        if Faculty.where(nombre:nombre).first.id == facultad.id
          direccion = Direction.where(id:facultad.id).first

          if Direction.where(ciudad:ciudad,calle:calle).count==0
            direccion.ciudad=ciudad
            direccion.calle = calle
            if direccion.save
              flash[:message] = "Facultad modificada"
              flash[:messageOk] = true
            else
              flash[:message] = "No se pudo modificar la facultad"
              flash[:messageError] = true
            end
          else
            if Direction.where(ciudad:ciudad,calle:calle).first.id == direccion.id
              flash[:message] = "No hay modificaciones para hacer"
              flash[:messageOk] = true
            else
              flash[:message] = "La direccion ingresada pertenece a otra facultdad"
              flash[:messageError] = true
            end
          end
        else
          flash[:message] = "El nombre ingresado pertenece a otra facultdad"
          flash[:messageError] = true
        end
      end

    else
      flash[:message] = "Debe completar los campos"
      flash[:messageError] = true
    end

    redirect_to faculties_index_path


  end



   def delete
    if session[:user_id]!=0 && Usuario.new(session[:user_id]).getFuncionalidad("Administrar Facultades")
      @facu=Faculty.find(params[:format])
      @facu.activo = false
      @facu.save
      dire=Direction.find(@facu.direction_id)
      if Faculty.where(direction_id:dire.id).where(activo: true).count == 0#Si la direccion, no esta en ninguna faculta activa
        dire.activo = false#borrado logico de direccion
        dire.save
      end
      checkeoSinRelaciones
      redirect_to faculties_index_path
    end
  end

  def checkeoSinRelaciones
    if Question.all.where(faculty_id:@facu.id).count==0 && User.all.where(faculty_id:@facu.id).count==0
        @facu.destroy
        dire=Direction.find(@facu.direction_id)
        if Faculty.where(direction_id:dire.id).count == 0
          dire.destroy
        end
    end
  end

end
