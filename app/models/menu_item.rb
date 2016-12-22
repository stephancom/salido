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

  # From spec:
  # If the Menu Item has a price specified for the Price Level that correlates with the current Order Type and Day Part, use that Price Level.
  # Else, if the Menu Item has a price specified for the Price Level that correlates with the current Order Type, use that Price Level.
  # Otherwise, the Menu Item has no currently applicable Price Level and cannot be purchased.
  # NOTE: it would seem more natural to find a local_pricing where day part is NULL, but that does not appear to be what the spec says

  # TODO this would be more efficient in a menu fetch method on Location for given order type/day part

  # determine if item is available at location for order type and day part
  def available_at_location_for_order_type_and_day_part?(location, order_type, day_part)
    !price_at_location_for_order_type_and_day_part(location, order_type, day_part).nil?
  end

  # find price for item at given location/order_type/day part
  def price_at_location_for_order_type_and_day_part(location, order_type, day_part)
    possible_prices = prices.for_location_and_order_type_and_day_part(location, order_type, day_part)
    possible_prices = prices.for_location_and_order_type(location, order_type) if possible_prices.empty?
    possible_prices.first
  end
end
