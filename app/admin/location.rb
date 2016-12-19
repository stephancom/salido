ActiveAdmin.register Location do
	belongs_to :brand
	navigation_menu :brand
	permit_params :name
	remove_filter :brand, :day_parts, :local_pricings

  index do
    selectable_column
    column :name
    column :day_parts do |location|
    	link_to location.day_parts.count, admin_location_day_parts_path(location)
    end
    column :local_pricings do |location|
      link_to location.local_pricings.count, admin_location_local_pricings_path(location)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :brand
      row :created_at
      row :updated_at
      row :local_pricings do
        day_parts = location.day_parts + [nil]
        table do
          thead do
            td
            day_parts.each do |day_part|
              td day_part.try(:name) || 'anytime'
            end
          end
          tbody do
            brand.order_types.each do |order_type|
              tr do
                td order_type.name
                day_parts.each do |day_part|
                  td location.local_pricings.where(order_type: order_type, day_part: day_part).first.try(:price_level).try(:name)
                end
              end
            end
          end
        end
      end
    end
    active_admin_comments
  end

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

  action_item :local_pricings, only: [:show, :edit] do
    link_to 'Local Pricings', admin_location_local_pricings_path(location)
  end

  sidebar "Local Pricings", only: [:show, :edit] do
    ul do
      location.local_pricings.each do |p|
        li link_to p.name, admin_location_local_pricing_path(location, p)
      end
    end
    h4 link_to 'Add Local Pricing', new_admin_location_local_pricing_path(location)
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
