require 'rails_helper'
@task = Task.create(title:1)
RSpec.describe Task do
  after(:example) do 
    Task.destroy_all
    User.destroy_all
  end

  before(:example) do 
    @user = User.create!(name:"John", email:"aogc@gmail.com", password:"12345678")   
  end
  
  context 'with 2 or more tasks' do
    
  # query  
    it 'serch_by_title_and_status' do 

    title_with_s = @user.tasks.create(title:"s", status: "pending", content: "")
    status_with_s = @user.tasks.create(title:1, status: "processing", content: "") 
    expect(Task.ransack({title_or_status_cont:"s"}).result(distinct: true).order(:id)).to eq([title_with_s, status_with_s])
    end
  # sort  
    it 'orders them with created_at' do 
      t1 = @user.tasks.create(title:1, content: "")
      t2 = @user.tasks.create(title:1, content: "")
      expect(Task.ordered_by_created_at).to eq([t1,t2]) 
    end

    it 'orders them with end time' do
      past = @user.tasks.create(title:1, end:'2021-11-16 00:00:00',content: "" )
      now = @user.tasks.create(title:1, end:'2021-11-18 00:00:00', content: "")   
      expect(Task.ordered_by_endtime).to eq([past, now])
    end

    it 'orders them with priority' do 
      high = @user.tasks.create(title:'h', priority: "high", content: "")
      low = @user.tasks.create(title:'l', priority: "low", content: "")
      expect(Task.ordered_by_priority).to eq([high, low])
    end 
    
  end 
  # validation
  context 'validations with different situations' do 
    it 'fails without title' do 
      expect(Task.new(content:'123')).to be_invalid
    end

    it 'fails with content over 100 words' do 
      @task = Task.new
      @task.content = 'a' * 101
      expect(@task).to be_invalid
    end

    it 'passes with title' do
       expect(@user.tasks.new(title:'hi')).to be_valid
    end

    it 'passes with title and content less than 100 words' do
      expect(@user.tasks.new(title:'hi', content:'hello')).to be_valid
   end
  end
end
