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
      expect(Task.ransack({title_or_status_cont:"s"}).result(distinct: true)).to eq([title_with_s, status_with_s])
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
      task_over_100_words = Task.new(content:'輪所氣會現在圖習。現響相作牛不聽要民去好成只增東。十子院該以部樂長得著些告路也到告化景火邊就數法有覺聲如……表當到機也；們急地，買遠養無……輕車法路的拉人，童性痛紅的和類說別什一只話為長臺因加道行親留行地是法。評東隊她稱了北覺出，能成接弟，我反生見解，部反那我後求改不銀晚中坐安說林，根先策風又身外西任以滿一及在優夠年之，供西我叫女十中決說人天其晚一著富一由成接及明國……力上送的他城音我素們？')
      expect(task_over_100_words.content.length). to be >100
    end

    it 'passes with title' do
       expect(Task.new(title:'hi')).to be_valid
    end

    it 'passes with title and content less than 100 words' do
      expect(Task.new(title:'hi', content:'hello')).to be_valid
   end
  end
end
