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

	def friends
		User.find(self.relationships.map(&:user_id_two))
	end
	
end

