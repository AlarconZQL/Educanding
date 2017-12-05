class Usuario

  # método inicializar clase
  def initialize(id)

    if id > 0
      @user = User.find(id)
    else
      @user = nil
    end

  end

  def getFuncionalidad(funcionalidad)

    if @user != nil

      functionality_id = Functionality.all.where(nombre:funcionalidad).first.id

      if ( LevelFunctionality.all.where(level_id:@user.level_id,functionality_id:functionality_id).count > 0 )
        return true
      else
        return false
      end

    else
      return false
    end

  end

  def getLevel(level)

    if @user != nil

      if ( Level.all.where(id:@user.level_id).first.nombre == level)
        return true
      else
        return false
      end

    else
      return false
    end

  end



  def nombre
    return @user.nombre
  end


end
