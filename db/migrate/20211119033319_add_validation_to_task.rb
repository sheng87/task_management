class AddValidationToTask < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :content, :string, limit: 100
  end
end
