require 'rails_helper'
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

    title_with_s = @user.tasks.create!(title:"s", status: "pending", content: "")
    status_with_s = @user.tasks.create!(title:1, status: "processing", content: "")
    expect(Task.ransack({title_or_status_cont:"s"}).result(distinct: true).order(:id)).to eq([title_with_s, status_with_s])
    end


  end
  # validation
  context 'validations with different situations' do
    it 'fails without title' do
      expect(Task.create(content:'123')).to be_invalid
    end

    it 'fails with content over 100 words' do
      @task = Task.create(title: 'hi')
      @task.content = 'a' * 101
      expect(@task).to be_invalid
    end

    it 'passes with title and content less than 100 words' do
      expect(@user.tasks.create(title:'hi', content:'hello')).to be_valid
   end
  end
end
