class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :hotels, foreign_key: :user_id, dependent: :nullify
  has_many :properties, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_hotels, through: :favorites, source: :hotel

  # Кастомная валидация для почты
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: VALID_EMAIL_REGEX, message: "incorrect email" }

  def supervisor?
    role == 'supervisor'
  end

  def admin?
    role == 'admin'
  end

  def regular?
    role == 'user'
  end
end
