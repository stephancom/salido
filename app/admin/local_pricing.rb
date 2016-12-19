ActiveAdmin.register LocalPricing do
	belongs_to :location
	navigation_menu :location 
	permit_params :name
	remove_filter :location, :order_type, :price_level, :day_part

	index	do
    selectable_column
    column :order_type, sortable: :order_type_id do |local_pricing|
    	local_pricing.order_type_name
    end
    column :day_part, sortable: :day_part_id do |local_pricing|
    	local_pricing.day_part_name
    end
    column :price_level, sortable: :price_level_id do |local_pricing|
    	local_pricing.price_level_name
    end
    actions		
	end
end
