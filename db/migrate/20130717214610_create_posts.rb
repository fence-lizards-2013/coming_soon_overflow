class CreatePosts < ActiveRecord::Migration
  def change
    create_table  :posts do |t|
      t.string    :title
      t.string    :trailer_url
      t.string    :image_url
      t.date      :release_date
      t.string 		:critics_rating
      t.integer 	:critics_score
      t.integer 	:audience_score
      t.belongs_to :user # TODO-JW: this migration is earlier than your users migration, which is weird
    end

  end

end
