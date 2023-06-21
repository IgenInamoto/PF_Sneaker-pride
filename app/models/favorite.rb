class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :sneaker
    validates_uniqueness_of :sneaker_id, scope: :user_id
end
