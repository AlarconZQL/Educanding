class FacultiesController < ApplicationController
  def index
    if Usuario.new(session[:user_id]).getFuncionalidad("Administrar Facultades")
      @faculties=Faculty.all
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
  end

  def destroy
  end

  def update
  end
   def delete
    if session[:user_id]!=0 #Falta el chequeo de nivel de usuario
      @facu=Faculty.find(params[:format])
      @facu.activo = false
      @facu.save
      chekeoSinRelaciones
      redirect_to faculties_index_path
    end
  end

  def chekeoSinRelaciones
    if Question.all.where(faculty_id:@facu.id).count==0 && User.all.where(faculty_id:@facu.id).count==0
        @facu.destroy
    end
  end

end
