class User < ApplicationRecord
    has_many :recipes
    has_many :likes
    has_many :comments
    
    has_many :follows 

    has_many :follwer_relationships, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :follwer_relationships, source: :follower

    has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
    has_many :followings, through: :following_relationships, source: :following

    has_secure_password
end
