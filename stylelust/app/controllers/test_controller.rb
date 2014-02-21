class TestController < ApplicationController
  

	require 'net/http'
	require 'uri'
	require 'json'

	def index

		if Category.all.length == 0
			Category.create(name: "Tops")
			Category.create(name: "Bottoms")
			Category.create(name: "Shoes")
			Category.create(name: "Dresses")
			Category.create(name: "Accessories")
			Category.create(name: "Outerwear")
		end
		
		@count = 0
		categories = ["womens-tops", "skirts", "womens-pants", "shorts", "womens-shoes", "dresses", "womens-accessories", "womens-outerwear"]
		@category = Category.all
		until @count > 7
			offset = 0
			c = categories[@count]
			until offset >= 500


				url = "http://api.shopstyle.com/api/v2/products?pid=uid404-24629898-59&format=JSON&offset=#{offset}&limit=100&cat=#{c}"
				uri = URI.parse(url)
				response = Net::HTTP.get_response(uri)
				value = JSON.parse(response.body)
				value["products"].each do |product|
				# search for the item that matches the product name
				@item = Item.where(name: product["name"])
				# simplifies the call for me
				@item = @item[0]	
				
				# check to see if the item exists and if it does that it matches the product name
					if @item != nil && @item.name == product["name"]
						# update the item
						@item.update_attributes(name: product["name"], price: product["price"])
					else
						# if it fails it means it's a new item
						Item.create(name: product["name"], price: product["price"])
						# set the new item to @item
						@item = Item.last

						# now that we have a new item, add it to a category
						case @count
						when 0
							@category.all[0].items << @item
						when 1,2,3
							@category.all[1].items << @item
						when 4
							@category.all[2].items << @item
						when 5
							@category.all[3].items << @item
						when 6
							@category.all[4].items << @item
						when 7
							@category.all[5].items << @item
						end
					end

					if product["brand"] != nil 
						@brand = Brand.where(name: product["brand"]["name"])
						@brand = @brand[0]
					 	if @brand != nil && @brand.name == product["brand"]["name"]
					 			@brand.items << @item
					 	else
							Brand.create(name: product["brand"]["name"], items: [@item])
						end
					end

				end
				offset += 100
			end
			@count += 1
		end
			@brands = Brand.all
			@items = Item.all
			@categorys = Category.all
			render test_path
			

			
	end


end
