class AddDescToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :desc, :text
  end
end
