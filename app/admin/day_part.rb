ActiveAdmin.register DayPart do
	belongs_to :location
	navigation_menu :location 
	permit_params :name

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :location_full_name, as: :readonly, label: 'Location'
			f.input :name
		end
		f.actions
	end
end
