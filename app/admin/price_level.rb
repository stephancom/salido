ActiveAdmin.register PriceLevel do
	belongs_to :brand
	navigation_menu :brand
	permit_params :name
	remove_filter :brand

  index do
    selectable_column
    column :name
    actions
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
