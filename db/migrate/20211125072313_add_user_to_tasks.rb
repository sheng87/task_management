class AddUserToTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :user_id, :integer
    add_reference :tasks, :user, null: true, foreign_key: true
  end
end
