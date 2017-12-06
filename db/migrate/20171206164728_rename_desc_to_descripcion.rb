class RenameDescToDescripcion < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :desc, :descripcion
  end
end
