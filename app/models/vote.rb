class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :post
  validates_presence_of :user_id, :scope => [:post_id]
end