class Post < ActiveRecord::Base
  attr_accessible :title, :trailer_url, :image_url, :user_id, :release_date, :critics_score, :critics_rating, :audience_score
  belongs_to :user
  has_many :votes
  validates :title, presence: true
  validates :title, uniqueness: true


  def self.sort_by_release_date(posts)
    posts.sort_by do |post|
      post.release_date
    end.reverse
  end

  def self.sort_by_popularity(posts)
    posts.sort_by do |post|
      post.votes.where(value: -1).count - post.votes.where(value: 1).count
    end
  end

  def self.find_tomato name
    rotten_results = RottenTomatoes::RottenMovie.find(:title => name, :limit => 5)
  end

end