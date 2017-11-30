class LabelsController < ApplicationController
  def index
    @etiquetas=Label.all
  end

  def create
    if params[:nombre]!=""#si no esta vacio
      nombreFormato=params[:nombre].capitalize
      if Label.where(nombre:nombreFormato).count==0#Si no existe la etiqueta

         etiqueta=Label.new(nombre: nombreFormato,activo:true)
         if etiqueta.save#si se puede guardar
           redirect_to labels_index_path
         else#Si no se guardo, sale el error
           #este es un mensaje que se guarda en la variable global flash
           flash[:message] = "No se pudo crear la etiqueta"
           redirect_to labels_index_path
         end
       else#Si la etiqueta existe
        if Label.where(nombre:nombreFormato).first.activo==true
         #este es un mensaje que se guarda en la variable global flash
         flash[:message] = "La etiqueta ya existe"
         redirect_to labels_index_path
        else
          etiqueta=Label.where(nombre:nombreFormato).first
          etiqueta.activo = true
          if !etiqueta.save#Si no se guardo, sale el error
           flash[:message] = "No se pudo crear la etiqueta"
          end
          redirect_to labels_index_path
        end
       end
    end
  end

  def show
  end

  def destroy
  end

  def update
    label=Label.find(params[:label_id])
    label.nombre=params[:nombre].capitalize
    label.save
    redirect_to labels_index_path
  end
  def delete
    if session[:user_id]!=0 #Falta el chequeo de nivel de usuario
      @eti=Label.find(params[:format])
      @eti.activo = false
      @eti.save
      chekeoSinRelaciones
      redirect_to labels_index_path
    end
  end

  def chekeoSinRelaciones
    if QuestionLabel.all.where(label_id:@eti.id).count==0
        @eti.destroy
    end
  end

end
