class Vote < ActiveRecord::Base
  attr_accessible :value, :post_id, :user_id
  belongs_to :user
  belongs_to :post
  validates :post_id, :uniqueness => { :scope => [:user_id], :message => "has already been voted on" }
  validates :value, :inclusion => { :in => [-1, 0, 1], :message => "must be between -1 and +1"} # -1 is a downvote
end
