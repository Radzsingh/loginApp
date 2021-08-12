class User < ApplicationRecord
  attr_accessor :password
  validates :user_name,
                    presence: true,
                    uniqueness: true,
                    length: {:within => 6..40}
  validates :password,
                    presence: true,
                    length: {:within => 6..40}

  before_create :encrypt_password

   def authenticate(login_password)
     # adding salt to SHA1 to compare with the encrypted password
     salt= Rails.application.credentials[:salt] || "fallback_salt_key"
     encrypted_password= Digest::SHA1.hexdigest("#{salt}#{login_password}")
     (self.encypted_password == encrypted_password) ? true : false
   end

   def encrypt_password
     #  adding salt to SHA1 while encrypting password
     salt= Rails.application.credentials[:salt] || "fallback_salt_key"
     self.encypted_password= Digest::SHA1.hexdigest("#{salt}#{password}")
   end

   def record_attempt
     # increment the login attempts
     self.increment!(:login_attempts)
   end

   def reset_attempt
     # set login attempts to 0
     self.update_attribute('login_attempts', 0)
   end
end
