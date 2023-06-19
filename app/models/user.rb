class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :sneakers, dependent: :destroy
  has_many :sneaker_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  has_one_attached :profile_image
          
  validates :name,  uniqueness: true, length: { in: 2..20 } 
  validates :introduction, length: { maximum: 50 }
    
      
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'default-image.jpg'
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  # フォローした時の処理
  def follow(user)
    relationships.create(followed_id: user.id)
  end
  
  # フォローを外す時の処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end
  
  # フォローしているかの判定(フォローしていればtrueを返す)
  def following?(user)
    followings.include?(user)
  end
  
   # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match" #完全一致
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match" #前方一致
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match" #後方一致
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match" #部分一致
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
         
end
