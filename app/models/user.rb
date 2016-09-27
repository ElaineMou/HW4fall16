class User < ActiveRecord::Base
    def User.create_user! (hash = {})
        if hash[:user_id] != nil && hash[:email] != nil
            hash[:session_token] = SecureRandom.base64
            return User.create!(hash)
        end
    end
end