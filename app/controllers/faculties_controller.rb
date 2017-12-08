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
    if params[:nombre]!=""#si no esta vacio
      nombreFormato=params[:nombre].capitalize
      if Faculty.where(nombre:nombreFormato).count==0#Si no existe la facultad

         facultad=Faculty.new(nombre: nombreFormato,activo:true)
         if facultad.save#si se puede guardar
           redirect_to faculties_index_path
         else#Si no se guardo, sale el error
           #este es un mensaje que se guarda en la variable global flash
           flash[:message] = "No se pudo crear la etiqueta"
           redirect_to faculties_index_path
         end
       else#Si la facultad existe
        if Faculty.where(nombre:nombreFormato).first.activo==true
         #este es un mensaje que se guarda en la variable global flash
         flash[:message] = "La facultad ya existe"
         redirect_to faculties_index_path
        else
          facultad=Faculty.where(nombre:nombreFormato).first
          facultad.activo = true
          if !facultad.save#Si no se guardo, sale el error
           flash[:message] = "No se pudo crear la facultad"
          end
          redirect_to faculties_index_path
        end
       end
    end
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
