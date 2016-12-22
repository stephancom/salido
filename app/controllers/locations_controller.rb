class LocationsController < InheritedResources::Base
	belongs_to :brand

	def show
		@brand = resource.brand
		@day_parts = resource.available_day_parts
		@day_part = params.key?(:day_part) ? @day_parts.where(id: params[:day_part]).first : @day_parts.first
		@order_types = resource.order_types_for_day_part(@day_part)
		@menu_items = resource.menu_items
	end
end

