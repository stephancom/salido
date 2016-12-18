class Brand < ApplicationRecord
	has_many :locations
	has_many :menu_items

	validates :name, uniqueness: true, presence: true # redundant due to database constraints but I like doing it anyway
end
