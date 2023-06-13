class Sneaker < ApplicationRecord
    
    belongs_to :user
    has_many :sneaker_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
   
    validates :body, presence: true,  length: { maximum: 200 }
    
     has_one_attached :image
    
    def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    end
    
    def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    end
    
end
