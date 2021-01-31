class History < ActiveRecord::Base
    belongs_to :patient
    has_many :subjectives
end