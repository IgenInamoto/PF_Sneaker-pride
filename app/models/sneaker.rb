class Sneaker < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    has_many :sneaker_comments, dependent: :destroy
   
    validates :body, presence: true,  length: { maximum: 200 }
    
    def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    end
    
end
