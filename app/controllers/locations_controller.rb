class LocationsController < InheritedResources::Base
	belongs_to :brand

	before_filter :day_part

private

	def day_part
		@day_part = if params.key?(:day_part)
			resource.day_parts.where(id: params[:day_part]).first
		else
			resource.day_parts.first
		end
	end
end

