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

  #validation
  validates :title, presence: true
  validates :content, length: { maximum: 100}

  # scope
  scope :ordered_by_created_at, -> {order(created_at: :asc)}
  scope :ordered_by_endtime, -> {order(end: :asc)}
  scope :ordered_by_priority, -> {order('priority DESC NULLS LAST')}
end
