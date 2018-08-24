class Episode < ActiveRecord::Base
  belongs_to :title
  
  attr_accessor :source
  
end
