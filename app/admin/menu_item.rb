ActiveAdmin.register MenuItem do
	belongs_to :brand
	navigation_menu :brand
	permit_params :name, prices_attributes: [:id, :price_level_id, :amount, :_destroy]
	remove_filter :brand
	remove_filter :price_levels
	remove_filter :prices

  index do
    selectable_column
    column :name
    brand.price_levels.each do |price_level|
    	column price_level.name do |menu_item|
    		number_to_currency(menu_item.prices.where(price_level: price_level).first.amount) if menu_item.prices.where(price_level: price_level).any?
    	end
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
  		row :prices do
  			price_levels = brand.price_levels
		  	table do
		  		thead do  			
			  		tr do
			  			price_levels.each do |price_level|
			  				th price_level.name
			  			end
			  		end
		  		end
		  		tbody do
			  		tr do
			  			price_levels.each do |price_level|
			  				td number_to_currency(menu_item.prices.where(price_level: price_level).first.try(:amount)) || 'n/a'
			  			end
			  		end
		  		end
		  	end
  		end
  	end
		active_admin_comments
  end

	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :brand_name, as: :readonly, label: 'Brand'
			f.input :name
		end
		# this is crude and needs work
		f.inputs do
			f.has_many :prices, allow_destroy: true do |p|
				p.input :price_level, collection: brand.price_levels
				p.input :amount #, label: p.object.price_level.try(:name)
			end
		end
		f.actions
	end
end
