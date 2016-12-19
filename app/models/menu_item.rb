class MenuItem < ApplicationRecord
  belongs_to :brand
  has_many :price_levels, through: :brand
  has_many :prices, dependent: :destroy

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true

  accepts_nested_attributes_for :prices, allow_destroy: true

  def full_name
  	"#{brand_name} - #{name}"
  end

  def price
  	prices.first.try(:amount) # temporary
  end
end
