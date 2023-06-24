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
          
  validates :name, length: { minimum: 2, maximum: 20 },  uniqueness: true
  validates :introduction, length: { maximum: 50 }
    
      
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'noimage.png'
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user| #find_or_create_byは、データの検索と作成を自動的に判断して処理を行う、Railsのメソッド。
      user.password = SecureRandom.urlsafe_base64 #SecureRandom.urlsafe_base64は、ランダムな文字列を生成するRubyのメソッドの一種。
      user.name = "guestuser"
    end
  end
  
  # def guest_check
  #   if current_menber == Menber.find(1)
  #     redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
  #   end
  # end
  
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
