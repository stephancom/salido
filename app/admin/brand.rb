ActiveAdmin.register Brand do
	permit_params :name

	action_item :locations, only: [:show, :edit] do
		link_to 'Locations', admin_brand_locations_path(brand)
	end

  sidebar "Locations", only: [:show, :edit] do
    ul do
      brand.locations.each do |l|
				li link_to l.name, admin_brand_location_path(brand, l)
      end
    end
		h4 link_to 'Add Location', new_admin_brand_location_path(brand)
  end
end
