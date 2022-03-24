class User < ApplicationRecord
    
    has_many :tweets, dependent: :destroy
    has_many :comments, dependent: :destroy

    acts_as_voter
    has_secure_password
    validates :username, presence: true, uniqueness: true

end
