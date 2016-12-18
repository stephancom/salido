ActiveAdmin.register Location do
	belongs_to :brand, optional: true
	# navigation_menu :brand
	permit_params :name

  action_item :day_parts, only: [:show, :edit] do
    link_to 'Day Parts', admin_location_day_parts_path(location)
  end

  sidebar "Day Parts", only: [:show, :edit] do
    ul do
      location.day_parts.each do |p|
        li link_to p.name, admin_location_day_part_path(location, p)
      end
    end
    h4 link_to 'Add Day Part', new_admin_location_day_part_path(location)
  end

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :brand_name, as: :readonly, label: 'Brand'
			f.input :name
		end
		f.actions
	end
end
