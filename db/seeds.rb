# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Environment variables (ENV['...']) can be set in the file .env file.

brand_names = ['French Toast Hut', 'Denise\'s', 'NSOC', 'Sheboygan Tame Legs', # NSOC = National Shack of Crepes
	'Emerald Thursday', 'Pickle Yard', 'Blue Oyster', 'Bosom\'s', 'Ruddfuckers', 'New City Trough']

brand_names.each do |brand_name|
	Brand.where(name: brand_name).first_or_create
end

neighborhoods = ['SoHo', 'TriBeCa', 'Village', 'Chelsea', 'Bowery', 'NoHo', 'Turtle Bay',
	'Bushwick', 'Dumbo', 'Red Hook', 'Williamsburg', 'Park Slope', 'Coney Island']

def fake_item
	item_prefix = %w(Mega Jumbo Fried Super Mini Kids Double Baked Macho Cajun Portuguese Sushi Farm BBQ Roasted Chocolate)
	items = %w(Beef Angus Steak Wings Chicken Ostrich Fish Shrimp Tuna Brisket Pork Bacon Duck Lemon)
	item_postfix = %w(Burger Omlette Sandwich Pizza Nachos Taco Torta Salad Sushi Platter Dog Waffle Pie)

	item = items.sample
	if [true,true,true,false].sample
		item = "#{item_prefix.sample} #{item}"
	end
	if [true,true,true,true,false].sample
		item = "#{item} #{item_postfix.sample}"
	end
	item
end

optional_price_levels = ['Happy Hour', 'Early Bird', 'Late Night', "Holiday", "Rush"]
order_types = ["Dine In", "Carry Out", "Delivery", "Counter Service", "Catering"]

Brand.all.each do |brand|
	if brand.locations.empty?
		neighborhoods.sample(rand(3..(neighborhoods.length-3))).each do |neighborhood_name|
			brand.locations.where(name: neighborhood_name).first_or_create
		end
	end
	if brand.menu_items.empty?
		rand(5..15).times do
			brand.menu_items.where(name: fake_item).first_or_create
		end
	end
	if brand.price_levels.empty?
		optional_price_levels.sample(rand(0..(optional_price_levels.length))).each do |price_level_name|
			brand.price_levels.where(name: price_level_name).first_or_create
		end
	end
	brand.price_levels.where(name: 'Regular').first_or_create # always make Regular price
	if brand.order_types.empty?
		order_types.sample(rand(1..(order_types.length))).each do |order_type_name|
			brand.order_types.where(name: order_type_name).first_or_create
		end
	end

	# source: https://www.englishclub.com/ref/esl/Power_of_7/7_Meals_of_the_Day_2946.htm
	# alternate: http://askmiddlearth.tumblr.com/post/41765286488/the-seven-daily-hobbit-meals
	# notably ommitted: midnight snack, late night, 'midnight breakfast', 'tiffin', 'bar snacks'
	# spec does not discuss mapping these to particular time ranges
	# which of course could be done, allowing for automatic generation of "hours of operation"
	# and automatically selecting the right prices based on the time of day.
	day_parts = %w(breakfast brunch elevenses lunch tea supper dinner)
	brand.locations.all.each do |location|
		if location.day_parts.empty?
			day_parts.sample(rand(1..(order_types.length))).each do |day_part_name|
				location.day_parts.where(name: day_part_name).first_or_create
			end
		end
	end

	brand.menu_items.each do |menu_item|
		if menu_item.prices.empty?
			levels = brand.price_levels
			default_price = rand(rand(menu_item.name.split(' ').count*10))+1

			levels.sample(rand(1..levels.count)).each do |price_level|
				menu_item.prices.where(price_level: price_level).first_or_create do |price|
					price.amount = default_price * (1 + ([-1,1].sample * 0.05 * (rand(5))))
				end
			end
		end
	end
end




