class Comment < ActiveRecord::Base
    belongs_to :patient

    attr_accessor :comments
end