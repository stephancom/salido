class Price < ApplicationRecord
  belongs_to :menu_item
  belongs_to :price_level

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :price_level_id, uniqueness: { scope: :menu_item_id }
  validates_each :price_level do |record, attr, value|
  	record.errors.add(attr, 'must belong to same brand as menu item') unless value and value.brand_id == record.menu_item.brand_id
  end

  delegate :name, to: :menu_item, prefix: :true
  delegate :name, to: :price_level, prefix: :true
end
