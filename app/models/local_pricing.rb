class LocalPricing < ApplicationRecord
	belongs_to :location
  belongs_to :order_type
  belongs_to :price_level
  belongs_to :day_part # optional
  delegate :brand, to: :location

  validates :location, presence: true
  validates :price_level_id, presence: true
  validates :order_type_id, uniqueness: { scope: [:location_id, :day_part_id] }, presence: true
  validates :day_part, uniqueness: {scope: [:location_id, :price_level_id, :order_type_id]} # redundant? 
  validates_each :price_level, :order_type, :day_part do |record, attr, value|
  	record.errors.add(attr, 'must belong to same brand as day part/location') if value and value.brand_id != record.brand.id
  end

  delegate :brand, to: :location
  delegate :full_name, to: :location, prefix: true
  delegate :id, to: :brand, prefix: true
  delegate :name, to: :order_type, prefix: true
  delegate :name, to: :price_level, prefix: true
  delegate :name, to: :day_part, prefix: true, allow_nil: true

  def name
  	"#{order_type.name} - #{day_part.try(:name) || 'anytime'}: #{price_level.name}"
  end

  def full_name
  	"#{location_full_name} - #{name}"
  end
end
