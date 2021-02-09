class User < ApplicationRecord
    attr_reader :password
    after_initialize :ensure_session_token
    
    validates  :email, :session_token , presence: true
    validates :password_digest, presence: {message: 'Password cannot be blank.'}
    validates :email, :session_token, uniqueness: true
    validates :password, length: {minimum: 5, allow_nil:true}




    def self.find_by_credentials(email,password)
        u = User.find_by(email: email)
        if u && u.is_password?(password)
            u
        else
            nil
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end

    def is_password?(pw)
        BCrypt::Password.new(self.password_digest).is_password?(pw)
    end



end