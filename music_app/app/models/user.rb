class User < ApplicationRecord
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true

    before_validation :ensure_session_token

    attr_reader :password

    def self.generate_unique_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(new_pass)
        self.password_digest = BCrypt::Password.create(new_pass)
        @password = new_pass
    end

    def is_password?(new_pass)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(new_pass)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        if user && is_password?(password)
            user
        else
            nil
        end
    end

    
end
