class User < ApplicationRecord
    has_many :recipes
    has_many :likes
    has_many :comments
    
    has_secure_password
end
