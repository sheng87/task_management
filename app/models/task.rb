class Task < ApplicationRecord
  include AASM

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
  belongs_to :user, optional: true

  #validation
  validates :title, presence: true
  validates :content, length: { maximum: 100}

  # scope
  scope :ordered_by_created_at, -> {order(created_at: :asc)}
  scope :ordered_by_endtime, -> {order(end: :asc)}
end
