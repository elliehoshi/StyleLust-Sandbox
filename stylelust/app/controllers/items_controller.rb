class ItemsController < ApplicationController
	def play	
		if params[:cat].blank?
			@items = Item.all
		else
			if params[:price].blank?
				@items = Category.find_by(name: params[:cat]).items
			else
				@items = Category.find_by(name: params[:cat]).items.where("price < ?", params[:price].to_f)
				if @items.length == 0
					@items = Category.find_by(name: params[:cat]).items
				end
			end
		end

		if params[:index].blank?
			@index = params[:index] = 0
		else
			@index = params[:index].to_i 
			if (@items.length < @index + 1)
				@index -= 1
			end
		end
	end

	def likeClicked
		

		render action: 'play'
	end
end