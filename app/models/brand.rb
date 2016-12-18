class Brand < ApplicationRecord
	has_many :locations

	validates :name, uniqueness: true, presence: true # redundant due to database constraints but I like doing it anyway
end
