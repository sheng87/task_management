class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, presence: true
  scope :ordered_by_created_at, -> {order(created_at: :asc)}
end
