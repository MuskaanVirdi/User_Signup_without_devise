class User < ApplicationRecord
    has_one_attached :profile_image
    attr_accessor :password
    validates :first_name, :last_name, :date_of_birth, presence: true
    validates :mobile , presence:true ,length: {is:10}
    validates :password ,presence:true ,confirmation:true, length: {in: 6..50},:if => :password_validation_required?
    validates :email, uniqueness: true, length: { in: 5..50 }

    before_save :encrypt_password,:if => :password_validation_required?

    def password_validation_required?
        hashed_password.blank? || !password.blank?
    end




    def self.authenticate(email,password)
        user = find_by_email(email)
        return user if user && user.password_valid?(password)
    
      end 
    
    def password_valid?(password)
        self.hashed_password == encrypt(password)
    end

    private
    def encrypt_password
        return if password.blank?
        self.hashed_password = encrypt(password)
    end

    def encrypt(string)
        Digest::SHA1.hexdigest(string)
    end
end
