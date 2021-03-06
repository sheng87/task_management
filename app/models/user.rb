class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  # relation
  has_many :tasks, dependent: :destroy

  # validation
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  has_secure_password

  # query
  scope :find_admin, -> {where(admin: true).size}

end
