ActiveAdmin.register Brand do
	permit_params :name

  %i(locations menu_items price_levels order_types).each do |child_type|
    title = child_type.to_s.titleize
    action_item child_type, only: [:show, :edit] do
      link_to title, polymorphic_path([:admin, brand, child_type])
    end

    sidebar title, only: [:show, :edit] do
      ul do
        brand.send(child_type).each do |c|
          li link_to c.name, polymorphic_path([:admin, brand, c])
        end
      end
      h4 link_to "Add #{title.singularize}", new_polymorphic_path([:admin, brand, child_type.to_s.singularize])
    end
  end
end
