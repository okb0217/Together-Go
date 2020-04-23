class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :parties
  has_many :requests

  validates :introduction, presence: true, length: {maximum: 100}
  validates :age , :name , presence: true
end
