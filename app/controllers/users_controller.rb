class UsersController < ApplicationController

	def index
		@names = User.all.map(&:name)

		respond_to do |format|
			format.html
			format.json
		end
	end

end