class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :size, null: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end
