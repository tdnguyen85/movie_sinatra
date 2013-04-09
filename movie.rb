require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'better_errors'

require 'json'
require 'open-uri'
require 'uri'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path("..", __FILE__)
end 

get '/' do 

	erb :home
end

get '/search' do
	@movie_title = params[:movie_title]
	file_search = open("http://www.omdbapi.com/?s=#{URI.escape(@movie_title)}")
	@results = JSON.load(file_search.read) || []
	erb :search_result
end

get '/single-movie-info/:imdb_id' do
	@imdb_id = params[:imdb_id]
	file_movie = open("http://www.omdbapi.com/?i=#{URI.escape(@imdb_id)}")
	@imdb_result = JSON.load(file_movie.read)
	erb :single_movie_info
end


