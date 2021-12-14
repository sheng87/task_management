class AddDefaultToTaskPriority < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :priority, :integer, default: 0
  end
end
