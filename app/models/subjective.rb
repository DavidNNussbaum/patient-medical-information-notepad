class Subjective < ActiveRecord::Base
    belongs_to :patient

    attr_accessor :subjectives
end