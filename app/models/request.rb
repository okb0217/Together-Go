class Request < ApplicationRecord
	belongs_to :user
	belongs_to :party

	belongs_to :partner_user, class_name: "User"
	belongs_to :partner_party, class_name: "Party"
end
