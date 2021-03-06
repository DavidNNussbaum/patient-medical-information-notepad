class Patient < ActiveRecord::Base
    has_one :history
    has_one :subjective
    has_many :comments

    has_secure_password
    validates :username, presence: true, uniqueness: true
end