class Task < ApplicationRecord
  # reation
  belongs_to :user, optional: true

  #validation
  validates :title, presence: true
  validates :content, length: { maximum: 100}

  # scope
  scope :ordered_by_created_at, -> {order(created_at: :asc)}
  scope :ordered_by_endtime, -> {order(end: :asc)}
end
