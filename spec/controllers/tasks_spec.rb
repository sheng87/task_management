require 'rails_helper'
RSpec.describe TasksController do
  describe "tasks_controller actions" do 
    before(:all) do
      @task = Task.create(title:'嗨嗨')
    end
    after(:all) do 
      @task.destroy
    end
    
      it 'can be created' do 
        expect(@task).to be_valid
      end

      it 'can be read' do 
        expect(Task.find_by_title("嗨嗨")).to eq(@task)
      end

      it 'can be updated' do 
        Task.update(title:"你好")
        expect(Task.find_by_title:"你好").to eq(@task)
      end
     
      it 'can be destroyed' do 
        @task.destroy
        expect(Task.count).to eq(0)
      end
  end
end
