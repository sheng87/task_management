class CreateJoinTableForTagAndTask < ActiveRecord::Migration[6.1]
  def change
    create_table :tags_tasks, id: false do |t|
      t.belongs_to :task, index: true
      t.belongs_to :tag, index: true
    end  
  end
end
