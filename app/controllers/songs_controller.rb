require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do 
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'  
  end  

  post '/songs' do
    @song = Song.create(:name => params["Name"]) 

    @artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.artist = @artist

    @song.genre_id = params[:genres]

    @song.save 

    flash[:message] = "Successfully created song."

    redirect("/songs/#{@song.slug}")

  end 
   
end 