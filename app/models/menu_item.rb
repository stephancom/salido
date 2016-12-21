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

  def available_at_location_for_order_type_and_day_part?(location, order_type, day_part)
    !price_at_location_for_order_type_and_day_part(location, order_type, day_part).nil?
  end

  def price_at_location_for_order_type_and_day_part(location, order_type, day_part)
    price =  prices.joins(price_level: { local_pricings: [:day_part, :location] }).
                    where(price_level: { local_pricings: { order_type_id: order_type.id, 
                                                           day_part_id: day_part.id, 
                                                           location_id: location.id } })

    if price.empty?
      price =  prices.joins(price_level: { local_pricings: [:day_part, :location] }).
                      where(price_level: { local_pricings: { order_type_id: order_type.id,
                                                             location_id: location.id } })
    end

    price.first
  end
end
