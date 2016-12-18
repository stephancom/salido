class Brand < ApplicationRecord
	has_many :locations
	has_many :menu_items
	has_many :price_levels
	has_many :order_types

	validates :name, uniqueness: true, presence: true # redundant due to database constraints but I like doing it anyway
end
