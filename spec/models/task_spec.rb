require 'rails_helper'

RSpec.describe Task do
  after(:example) do 
    Task.destroy_all
  end
  
  context 'with 2 or more tasks' do 
    let(:title_with_s) { Task.create(title:"s", status: "pending")}
    let(:status_with_s) { Task.create(title:1, status: "processing")}
    let(:past) { Task.create(title:1, end:'2021-11-16 00:00:00')}
    let(:now) { Task.create(title:1, end:'2021-11-18 00:00:00')}
    let(:high) {Task.create(title:'h', priority: "high")}
    let(:low) {Task.create(title:'l', priority: "low")}

  # query  
    it 'serch_by_title_and_status' do 
      expect(Task.ransack({title_or_status_cont:"s"}).result(distinct: true)).to eq([status_with_s, title_with_s])
    end
  # sort  
    it 'orders them with created_at' do 
      t1 = Task.create(title:1)
      t2 = Task.create(title:1)
      expect(Task.ordered_by_created_at).to eq([t1,t2]) 
    end

    it 'orders them with end time' do   
      expect(Task.ordered_by_endtime).to eq([past, now])
    end

    it 'orders them with priority' do 
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
       expect(Task.new(title:'hi')).to be_valid
    end

    it 'passes with title and content less than 100 words' do
      expect(Task.new(title:'hi', content:'hello')).to be_valid
   end
  end
end
