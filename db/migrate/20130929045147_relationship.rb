class Relationship < ActiveRecord::Migration
  def change
  	create_table :relationships do |t|
  		t.string    :friend_one_uid
  		t.string    :friend_two_uid
  		t.integer     :user_id_one
  		t.integer     :user_id_two
  	end
  end
end
