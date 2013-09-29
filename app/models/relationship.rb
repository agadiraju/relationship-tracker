class Relationship < ActiveRecord::Base
	belongs_to :user, :foreign_key => "user_id_one"
	belongs_to :friend, :class_name => "User", :foreign_key => "user_id_two"
end
