class Location < ApplicationRecord
  belongs_to :brand
  has_many :day_parts, dependent: :destroy
  has_many :local_pricings
  has_many :order_types, through: :local_pricings

  validates :name, uniqueness: {scope: :brand}, presence: true

  delegate :name, to: :brand, prefix: true
  delegate :menu_items, to: :brand

  def full_name
  	"#{brand_name} - #{name}"
  end

  # menu items can only be priced at a location for a given order type 
  # if there is a corresponding local pricing with that order type and
  # either the given day part or nil
  def day_parts_for_order_type(order_type)
  	if local_pricings.where(order_type: order_type).any?
  		day_parts
  	else
  		day_parts.joins(local_pricings: { order_type: order_type }).distinct
  	end
  end

  # returns order types that are configured for given day part
  # NOTE: if a location has no price configuration for a given day part
  # then that location is not available for that day part.
  def order_types_for_day_part(day_part)
  	order_types.for_day_part(day_part).or(order_types.day_part_null).distinct
  end

  # returns price level for given order type and day part.
  # if no price level is available for a given day part, returns the first price level for ANY day part
  # if no price level is available for that order type, returns nil
  # (note: the spec is ambiguous on this point - 
  # if there is no price level configured for that day part,
  # is that day part available for that order type at all?  I'm assuming yes.)
  def price_level_for_order_type_and_day_part(order_type, day_part)
  	pls = local_pricings.where(order_type_id: order_type, day_part_id: day_part)
  	pls = local_pricings.where(order_type_id: order_type) if pls.empty?
		pls.first
  end

  def menu_for_order_type_and_day_part(order_type, day_part)
  	# TODO
  	# sketch
  	MenuItem.joins(	brand_id: brand, prices: { price_level: { local_pricings: { day_part_id: [day_part, nil] }, order_type_id: order_type } } )
  end
end
