class Brand < ApplicationRecord
	has_many :locations, dependent: :destroy
	has_many :menu_items, dependent: :destroy
	has_many :price_levels, dependent: :destroy
	has_many :order_types, dependent: :destroy

	validates :name, uniqueness: true, presence: true # redundant due to database constraints but I like doing it anyway
end
