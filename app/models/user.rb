class User < ApplicationRecord
  has_secure_password
  has_many :orders, dependent: :destroy

  STAFF_REGISTRATION_PASSWORD = "JS2504"

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { message: "そのユーザーネームは使用されています" }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :role, inclusion: { in: %w[customer staff] }
  validates :language, inclusion: { in: %w[ja hiragana en] }

  def customer?
    role == "customer"
  end

  def staff?
    role == "staff"
  end
end
