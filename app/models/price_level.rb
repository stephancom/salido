class PriceLevel < ApplicationRecord
  belongs_to :brand
  has_many :prices, dependent: :destroy
  has_many :local_pricings, dependent: :destroy

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true

  def full_name
  	"#{brand_name} - #{name}"
  end
end
