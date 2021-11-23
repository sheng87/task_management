class AddIndexToTask < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, [:title, :status]
  end
end
