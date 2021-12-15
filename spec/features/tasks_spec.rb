require 'rails_helper'
RSpec.describe.feature "Tasks", type: :feature do
  let(:user) { User.create!(name:"John", email:"101@gmail.com", password:"12345678", password_confirmation:"12345678") }
  let(:task) { Task.last }
    after(:example) do
      User.destroy_all
    end

  context "tasks 以起始時間排序" do

    before do
      Task.create(title:"1", content:"", user_id: user.id)
      Task.create(title:"2", content:"", user_id: user.id)
      signin_user
    end
    scenario '先1後2' do
      visit tasks_url
      click_link "起始時間"
      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content("1")
      end

      within 'tbody tr:nth-child(2)' do
        expect(page).to have_content("2")
      end

    end
  end

  context "tasks 以結束時間排序" do

    before do
      Task.create(title:"future", content:"", end: DateTime.new(2021, 12, 31, 00, 00, 00), user_id: user.id)
      Task.create(title:"past", content:"", end: DateTime.new(2000, 12, 31, 00, 00, 00), user_id: user.id)
      signin_user
    end
    scenario '先future後past' do
      visit tasks_url
      click_link "結束時間"
      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content("future")
      end

      within 'tbody tr:nth-child(2)' do
        expect(page).to have_content("past")
      end

    end
  end

  context "tasks 以優先順序排序" do

    before do
      Task.create(title:"high", content:"", priority: 2, user_id: user.id)
      Task.create(title:"low", content:"", priority: 0, user_id: user.id)
      signin_user
    end

    scenario '先high後low' do
      visit tasks_url
      click_link "優先順序"
      within 'tbody tr:nth-child(1)' do
        expect(page).to have_content("high")
      end

      within 'tbody tr:nth-child(2)' do
        expect(page).to have_content("low")
      end

    end
  end


  context "tasks 基本CRUD" do

    before do
      user
      signin_user
    end

    scenario '#create' do
      visit new_task_path
      fill_in "task[title]", with: 123
      click_button "Submit"
      visit tasks_url
      expect(user.tasks.last.title.to_i).to eq 123
    end

    scenario '#update' do
      Task.create(title: "QQ",content: "qq", user_id: user.id)
      visit tasks_url
      click_link "編輯"
      fill_in "task[title]", with: "Hi"
      click_button "Submit"
      visit tasks_url
      expect(page).to have_content('Hi')
      expect(task.title). to eq "Hi"
    end

    scenario '#destroy' do
      Task.create(title: "QQ",content: "qq", user_id: user.id)
      visit tasks_url
      click_link "刪除"
      expect(page).not_to have_content('qq')
      expect(Task.count).to be(0)
    end
  end


  private
  def signin_user
    visit login_path
    fill_in("session[email]", with: "101@gmail.com")
    fill_in("session[password]", with: "12345678")
    click_button("登入")
  end

end
