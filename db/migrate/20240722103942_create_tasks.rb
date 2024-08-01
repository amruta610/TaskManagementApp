class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :category
      t.string :priority
      t.string :status

      t.timestamps
    end
  end
end
