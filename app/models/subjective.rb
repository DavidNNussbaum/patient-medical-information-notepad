class Subjective < ActiveRecord::Base
    belongs_to :patient
    has_many :histories

    attr_accessor :subjectives
end