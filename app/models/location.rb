class Location < ApplicationRecord
  belongs_to :brand
  has_many :day_parts

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true
  delegate :menu_items, to: :brand

  def full_name
  	"#{brand_name} - #{name}"
  end
end
