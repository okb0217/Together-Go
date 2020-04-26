class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :parties
  has_many :requests

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  validates :introduction, length: {maximum: 100}
  validates :name , presence: true
end
