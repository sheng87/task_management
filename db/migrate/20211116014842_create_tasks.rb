class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.text :content
      t.string :label
      t.string :priority
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
