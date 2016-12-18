class MenuItemsController < InheritedResources::Base
	belongs_to :brand

  private

    def menu_item_params
      params.require(:menu_item).permit(:name, :brand_id)
    end
end

