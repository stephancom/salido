class OrderType < ApplicationRecord
  belongs_to :brand
  has_many :local_pricings, dependent: :destroy

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true

  scope :for_day_part, -> (day_part) { joins(:local_pricings).where( local_pricings: { day_part: day_part }) } 
  scope :day_part_null, -> { for_day_part(nil) }

  def full_name
  	"#{brand_name} - #{name}"
  end
end
