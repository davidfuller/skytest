class BssTitleId < ActiveRecord::Base

    belongs_to :episode

    attr_accessor :source

end
