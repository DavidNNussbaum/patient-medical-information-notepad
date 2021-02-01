class Patient < ActiveRecord::Base
    has_many :histories
    has_many :subjectives
    has_many :comments

    has_secure_password
end