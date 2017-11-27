if usuarioPunto.puntos+modificacionPuntuacion >= 0
  usuarioPunto.puntos=usuarioPunto.puntos+modificacionPuntuacion
  if usuarioPunto.save
    niveles = Level.all.order(created_at: :DESC) # ordena los niveles de mayor a menor puntuacion en un arreglo
    i = 0
    while usuarioPunto.puntos<niveles[i].puntos && i<size do # avanzo a un nivel de menor rango siempre que mis puntos sean menores que los del actual
       i = i+1
    end # al salir del lazo 'i' me indica la posicion del nivel que me corresponda en el arreglo
    if usuarioPunto.level_id != niveles[i].id # actualizo el nivel si es distinto de mi nivel actual
      usuarioPunto.level_id = niveles[i].id
      if usuarioPunto.save == false
        flash[:message]="Ocurrio un error al actualizar un nivel"
      end
    end
end
