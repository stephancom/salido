class LocationsController < InheritedResources::Base
	belongs_to :brand

  private

    def location_params
      params.require(:location).permit(:name, :brand_id)
    end
end

