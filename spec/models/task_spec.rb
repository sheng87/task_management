require 'rails_helper'
RSpec.describe Task do
  after(:all) do 
    Task.destroy_all
  end
  context 'with 2 or more tasks' do 
    it 'orders them from the past to the time close to present' do 
      t1 = Task.create(title:1)
      t2 = Task.create(title:2)
      expect(Task.ordered_by_created_at).to eq([t1,t2]) 
    end
  end  
end
