# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



def create_movie_post title
  movie_list = Post.find_tomato title

  if movie_list.is_a? Array
    movie = movie_list.first
  else
    movie = movie_list
  end
  title = movie.title
  if movie.respond_to?(:links) && movie.links.respond_to?(:clips)
    clips_url = movie.links.clips
  end

  if movie.respond_to?(:posters) && movie.posters.respond_to?(:detailed)
    image_url = movie.posters.detailed
  end

  release_date = movie.release_dates.theater
  critics_rating = movie.ratings.critics_rating
  critics_score = movie.ratings.critics_score
  audience_score = movie.ratings.audience_score
  

  movie_post = Post.new(title: movie.title, image_url: image_url,
                        trailer_url: 'http://www.apple.com/trailers', release_date: release_date,
                        critics_rating: critics_rating, critics_score: critics_score, audience_score: audience_score)
  # movie_post.save
  return movie_post
end




user = User.new(email: 'navidm@gmail.com', password: 'password', password_confirmation: 'password')
user.posts << create_movie_post('Only God Forgives')
user.posts << create_movie_post('Kick-Ass 2')
user.posts << create_movie_post('Elysium')
user.save


user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password')
user.posts << create_movie_post('Broken')
user.posts << create_movie_post('The Good Road')
user.posts << create_movie_post('Computer Chess')
user.save


movie_titles = [ ['Pacific Rim', 'Monsters University', 'World War Z'],
                  ['Way, Way Back', 'Fruitvale Station', 'Man of Steel'],
                  ['The attack', 'the bling ring', "I'm so excited"],
                  ['The Hunt', 'Crystal Fairy', 'Museum Hours'],
                  ['Byzantium', 'Viola', 'The Conjuring'] 
                ]


# debugger 
# ''

5.times do |i|
  user = User.new(email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
  3.times do |j|
    #puts "i: #{i}, j: #{j}"
    user.posts << create_movie_post(movie_titles[i][j])
    user.save
  end
end

vote_choice = [1, -1]
Post.all.each do |post|
  User.all.each do |user|
    post.votes.create(value: vote_choice.sample, user_id: user.id)
  end
end





