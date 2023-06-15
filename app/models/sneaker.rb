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
    
     # 検索方法分岐
    def self.looks(search, word)
        if search == "perfect_match" #完全一致
          @sneaker = Sneaker.where("body LIKE?","#{word}")
        elsif search == "forward_match" #前方一致
          @sneaker = Sneaker.where("body LIKE?","#{word}%")
        elsif search == "backward_match" #後方一致
          @sneaker = Sneaker.where("body LIKE?","%#{word}")
        elsif search == "partial_match" #部分一致
          @sneaker = Sneaker.where("body LIKE?","%#{word}%")
        else
          @sneaker = Sneaker.all
        end
    end
    
end
