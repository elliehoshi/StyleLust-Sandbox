# class LikesController < ApplicationController
# 	def index
# 		@items = current_user.items
# 	end
# end




class LikesController < ApplicationController
	
	def index
		if params[:cat].blank?
			@items = current_user.items
		else
			if params[:price].blank?
				@items = Category.find_by(name: params[:cat]).current_user.likes
			else
				@items = Category.find_by(name: params[:cat]).current_user.items.where("price < ?", params[:price].to_f)
				if @items.length == 0
					@items = Category.find_by(name: params[:cat]).current_user.items
				end
			end
		end
	end

end