ActiveAdmin.register Location do
	belongs_to :brand
	navigation_menu :brand
	permit_params :name

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :brand_name, as: :readonly, label: 'Brand'
			f.input :name
		end
		f.actions
	end
end
