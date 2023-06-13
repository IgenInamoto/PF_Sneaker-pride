class SneakerComment < ApplicationRecord
    
    belongs_to :user
    belongs_to :sneaker
    
    validates :comment, presence: true
    
end
