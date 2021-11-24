class ChangePriorityToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)'
  end
end
