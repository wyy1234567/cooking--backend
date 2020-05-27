class User < ApplicationRecord
    has_many :recipes
    has_many :likes
    has_many :comments
    
    has_many :follows 

    has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :follower_relationships, source: :follower

    has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
    has_many :followings, through: :following_relationships, source: :following

    has_secure_password

    validates :name, uniqueness: { case_sensitive: false }

    def follow_default
        spoonacular = User.find_by(name: 'Spoonacular')
        puts "DEFAULT FOLLOW"
        puts "DEFAULT FOLLOW"
        puts "DEFAULT FOLLOW"
        puts spoonacular
        puts self.followings
        puts "BEFORE"

        # following_spoon = Follow.create(user_id: self.id, following_id: spoonacular.id)

        self.followings << spoonacular
        puts "AFTER"
        puts self.followings
    end
end
