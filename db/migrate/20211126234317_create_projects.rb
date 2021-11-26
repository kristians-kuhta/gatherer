class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.date :due_date, null: false

      t.timestamps null: false
    end
  end
end
