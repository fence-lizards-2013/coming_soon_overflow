class Post < ActiveRecord::Base
  attr_accessible :title, :trailer_url, :image_url, :user_id, :release_date, :critics_score, :critics_rating, :audience_score
  belongs_to :user
  has_many :votes
  validates :title, presence: true
  validates :title, uniqueness: true


  def self.find_tomato name
    rotten_results = RottenTomatoes::RottenMovie.find(:title => name, :limit => 5)
  end

end