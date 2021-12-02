require 'rails_helper'
RSpec.describe TasksController do
  describe "tasks_controller actions" do 
    before(:all) do
      @user = User.create!(name:"John", email:"apgc@gmail.com", password:"12345678")   
      @task = @user.tasks.create(title:'嗨嗨', content: "")
    end
    after(:all) do 
      @user.destroy
    end
    
      it 'can be created' do 
        expect(@task).to be_valid
      end

      it 'can be read' do 
        expect(Task.find_by_title("嗨嗨")).to eq(@task)
      end

      it 'can be updated' do 
        @task.update(title:"你好")
        expect(Task.find_by_title:"你好").to eq(@task)
      end
     
      it 'can be destroyed' do 
        @task.destroy
        expect(Task.count).to eq(0)
      end
  end
end
