class Sneaker < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    has_many :sneaker_comments, dependent: :destroy
   
    validates :body, presence: true,  length: { maximum: 200 }
    
end
