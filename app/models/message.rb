class Message < ActiveRecord::Base
  attr_accessible :content, :username

  validates :username, presence: true
  validates :content, presence: true
  
end
