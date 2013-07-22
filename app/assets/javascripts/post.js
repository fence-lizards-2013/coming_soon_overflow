$(document).ready(function() {

  $('.submit-movie').on('submit', function(e) {
    e.preventDefault();
    var $movie = $('.movie.clicked');
    movieData = {
      title: $movie.find('.title').text().trim(),
      image_url: $movie.find('img').attr('src'),
      release_date: $movie.find('.release_date').text().trim(),
      clips_url: $movie.find('.clips_url').text().trim(),
      critics_rating: $movie.find('.critics_rating').text().trim(),
      critics_score: $movie.find('.critics_score').text().trim(),
      audience_score: $movie.find('.audience_score').text().trim()
    };
    $.post($(this).attr('action'), movieData, function(response) {
      $('.movie').removeClass('clicked');
      window.location = '/';
    });
  });

  $('#movie-list').on('click', '.movie', function(e){
    $('.movie').removeClass('clicked');
    $(this).addClass('clicked');
  });
});
