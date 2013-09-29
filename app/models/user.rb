class User < ActiveRecord::Base

	has_many :relationships, :foreign_key => :user_id_one

	def self.from_omniauth(auth)
	    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	  	    user.provider = auth.provider
	  	    user.uid = auth.uid
	  	    user.name = auth.info.name
	  	    user.oauth_token = auth.credentials.token
	  	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	  	    user.save!
	    end
	end

    def self.set_friends
    	oauth_access_token = 'CAACEdEose0cBAOZC7eShS03FpGBZCNSpLynUVWzTkH0HMHtkNw1ZBsWg7ByUpjyqQTya1QN3v2RZAD09mZCoBbPSibozY3KOU1JafJkbR3jLFFcZCJZCWOQcXdTnRfY9ZCNrZABN66nNloH64T7M1vffKEBh9K2MbjO0i2dL6GibZCr0T4zTuMAPZC84u6zEbYH2RoZD'
    	@graph = Koala::Facebook::API.new(oauth_access_token)
    	profile = @graph.get_object("me")
        friends = @graph.get_connections("me", "friends")

        friends.each do |friend|
        	u = User.new(uid: friend['id'], name: friend['name'])
        	u.save
        	#create_relationship_with(self, u)
        end
    end

    def get_relationships
		relationships
	end

	def get_profile
		oauth_access_token = 'CAACEdEose0cBAOZC7eShS03FpGBZCNSpLynUVWzTkH0HMHtkNw1ZBsWg7ByUpjyqQTya1QN3v2RZAD09mZCoBbPSibozY3KOU1JafJkbR3jLFFcZCJZCWOQcXdTnRfY9ZCNrZABN66nNloH64T7M1vffKEBh9K2MbjO0i2dL6GibZCr0T4zTuMAPZC84u6zEbYH2RoZD'
    	k = ::Koala::Facebook::API.new(oauth_access_token)
		pic = k.get_picture(self.uid, {type:"large"})
	end


    def self.create_relationship_with(new_friend_one, new_friend_two)
    	r = Relationship.new(user_id_one: new_friend_one.id, user_id_two: new_friend_two.id, 
    		friend_one_uid: new_friend_one.uid, friend_two_uid: new_friend_two.uid)
    	r.save()
    end
	
end

