class LabelsController < ApplicationController
  def index
    @etiquetas=Label.all
  end

  def create
    if params[:nombre]!=""#si no esta vacio
      if Label.where(nombre:params[:nombre]).count==0#Si no existe la etiqueta
         etiqueta=Label.new(nombre: params[:nombre])
         if etiqueta.save#si se puede guardar
           redirect_to labels_index_path
         else#Si no se guardo, sale el error
           #este es un mensaje que se guarda en la variable global flash
           flash[:message] = "No se pudo crear la cuenta"
           redirect_to labels_index_path
         end
       else#Si la etiqueta existe
         #este es un mensaje que se guarda en la variable global flash
         flash[:message] = "La etiqueta ya existe"
         redirect_to labels_index_path
       end
    end
  end

  def show
  end

  def destroy
  end
end
