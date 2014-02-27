class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :likes

	has_many :items, through: :likes, class_name: 'Item'
	has_many :brands, through: :items, class_name: 'Brand'
	has_many :categorys, through: :items, class_name: 'Category'

end
