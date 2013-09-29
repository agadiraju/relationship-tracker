class UsersController < ApplicationController

	def index()
		@data = User.find(session[:user_id]).get_relationships.map{ |x| {name: x.name, uid: x.uid} }
		respond_to do |format|
			format.html
			format.json
		end
	end
end