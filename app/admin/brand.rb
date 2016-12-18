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

	action_item :menu_items, only: [:show, :edit] do
		link_to 'Menu Items', admin_brand_menu_items_path(brand)
	end

  sidebar "Menu Items", only: [:show, :edit] do
    ul do
      brand.menu_items.each do |m|
				li link_to m.name, admin_brand_menu_item_path(brand, m)
      end
    end
		h4 link_to 'Add Menu Item', new_admin_brand_menu_item_path(brand)
  end
end
