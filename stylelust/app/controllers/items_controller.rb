class ItemsController < ApplicationController
	def play
		if params[:cat].blank?
			@items = Item.all
		else
			if params[:price].blank?
				@items = Category.find_by(name: params[:cat]).items
			else
				@items = Category.find_by(name: params[:cat]).items.where("price < ?", params[:price].to_f)
			end
		end		
	end
end