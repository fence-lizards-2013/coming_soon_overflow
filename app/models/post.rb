class Post < ActiveRecord::Base
  attr_accessible :title, :url, :image_url
  belongs_to :user
end
