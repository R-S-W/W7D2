class User < ApplicationRecord

    validates  :email, :password_digest,:session_token , presence: true
    validates :email, :session_token, uniqueness: true



    def self.generate_session_token
        SecureRandom::url_safe_base64
    end

    def reset_session_token!
    end

    def ensure_session_token
    end

    def password=(pw)
    end

    def is_password?(pw)
    end


end