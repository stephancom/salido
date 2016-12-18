class PriceLevel < ApplicationRecord
  belongs_to :brand

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true

  def full_name
  	"#{brand_name} - #{name}"
  end
end
