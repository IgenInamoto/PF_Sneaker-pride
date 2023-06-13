class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :sneakers, dependent: :destroy
  has_many :sneaker_comments, dependent: :destroy
  
  has_one_attached :profile_image
          
  validates :name,  uniqueness: true, length: { in: 2..20 } 
  validates :introduction, length: { maximum: 50 }
    
      
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'default-image.jpg'
  end
         
end
