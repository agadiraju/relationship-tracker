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

    def set_friends
    	oauth_access_token = 'CAACEdEose0cBAHNhyP0EvgZCagfmoTwvqlU2QpySxMw9pr2in0OPacQD1kI6Sr3KhNmFZB2GLXZAev4UFxBmlcDrtZApxN42l49ZATfzSfrpTqekmaU1C0X3YZARkDSfLQV6NF1K9nSykdabGmeYyjGWUX2FpoF5mS07HHdwL6u0ZBLbNbddoMZBVDtnUiHM9J4ZD'
    	graph = Koala::Facebook::API.new(oauth_access_token)
    	profile = graph.get_object("me")
        friends = graph.get_connections("me", "friends")

        friends.each do |friend|
        	u = User.new(uid: friend['id'], name: friend['name'])
        	u.save
        	create_relationship_with(u)
        end
    end

    def create_relationship_with(new_friend)
    	r = Relationship.new(user_id_one: id, user_id_two: new_friend.id, 
    		friend_one_uid: uid, friend_two_uid: new_friend.uid)
    	r.save()
    end

	def get_friends
		User.find(self.relationships.map(&:user_id_two))
	end
	
end

