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

Brand.all.each do |brand|
	if brand.locations.empty?
		neighborhoods.sample(rand(3..(neighborhoods.length-3))).each do |neighborhood_name|
			brand.locations.where(name: neighborhood_name).first_or_create
		end
	end
end