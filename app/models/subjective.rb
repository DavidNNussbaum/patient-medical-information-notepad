class Subjective < ActiveRecord::Base
    belongs_to :patient
    has_many :histories
end