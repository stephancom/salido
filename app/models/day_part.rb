class DayPart < ApplicationRecord
  belongs_to :location

  validates :name, uniqueness: {scope: :location}, presence: true

  delegate :brand, to: :location
  delegate :full_name, to: :location, prefix: true

  def full_name
  	"#{location_full_name} - #{name}"
  end
end
