class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hotels, foreign_key: :user_id, dependent: :nullify
  has_many :properties, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_hotels, through: :favorites, source: :hotel

  def supervisor?
    role == 'supervisor'
  end

  def regular?
    role == 'user'
  end
end
