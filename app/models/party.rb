class Party < ApplicationRecord
	belongs_to :user
  	has_many :requests, dependent: :destroy

  	validates :place, :age, :people_count,  presence: true
  	validates :introduction, presence: true, length: {maximum: 100}
end
