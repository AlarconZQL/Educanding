class AddNumVisitasToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :num_visitas, :integer
  end
end
