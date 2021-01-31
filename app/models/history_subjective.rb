class HistorySubjective < ActiveRecord::Base
    has_many :histories
    has_many :subjectives
    belongs_to :patient
end