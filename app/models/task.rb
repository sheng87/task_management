class Task < ApplicationRecord
  include AASM

  enum priority: { low: 0, medium: 1, high: 2}

  aasm column: :status do
    state :pending, initial: true
    state :processing, :completed

    event :proceed do
      transitions from: :pending, to: :processing
    end

    event :finish do
      transitions from: :processing, to: :completed
    end
  end
  # reation
  belongs_to :user
  has_and_belongs_to_many :tags

  #validation
  validates :title, presence: true
  validates :content, length: { maximum: 100}

  # scope
  scope :ordered_by_created_at, -> {order(:created_at)}
  scope :ordered_by_endtime, -> {order(:end)}
  scope :ordered_by_priority, -> {order(priority: :desc)}

  # 任務內容寫入hashtags
  after_create do
    task = Task.find_by(id: self.id)
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      task.tags << tag
    end
  end

  before_update do
    task = Task.find_by(id: self.id)
    task.tags.clear
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      task.tags << tag
    end
  end
end
