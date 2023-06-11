class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :sneakers, dependent: :destroy
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
          has_one_attached :profile_image
         
end
