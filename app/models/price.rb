class Price < ApplicationRecord
  belongs_to :menu_item
  belongs_to :price_level

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :price_level_id, uniqueness: { scope: :menu_item_id }
  validates_each :price_level do |record, attr, value|
  	record.errors.add(attr, 'must belong to same brand as menu item') unless value and value.brand_id == record.menu_item.brand_id # todo LOD
  end

  delegate :name, to: :menu_item, prefix: :true
  delegate :name, to: :price_level, prefix: :true

  scope :for_location_and_order_type, -> (location, order_type) { joins(price_level: :local_pricings).
			    where(price_level: { local_pricings: { order_type_id: order_type.id, location_id: location.id } }) 
	}
  scope :for_location_and_order_type_and_day_part, -> (location, order_type, day_part) {
  				for_location_and_order_type(location, order_type).where(price_level: { local_pricings: { day_part_id: day_part.id } })
  }
end
