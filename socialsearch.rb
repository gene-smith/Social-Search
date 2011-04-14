# -*- coding: utf-8 -*-

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'sinatra'

get '/' do
  erb :index
end

get '/search/' do
  redirect_to_url(params[:type],params[:search])
end

get '/:type/:search' do
  redirect_to_url(params[:type],params[:search])
end

not_found do
  'This is nowhere to be found'
end

error do
  'Sorry there was a nasty error'
end

private
def redirect_to_url(type,q)
    url = "http://www.google.com/search?q="
    url += case type
    when "myspace"
      "site%3Amyspace.com+inurl%3Amyspace+inurl%3Afuseaction"
    when "flickr"
      "site%3Aflickr.com%2Fpeople"
    when "linkedin"
      "site%3Alinkedin.com+inurl%3Ain"
    when "bebo"
      "site%3A.bebo.com+inurl%3Aprofile+inurl%3Abebo"
    when "youtube"
      "site%3Ayoutube.com%2Fuser"
    when "facebook"
      "site%3Afacebook.com"
    when "cafemom"
      "site%3Awww.cafemom.com+inurl%3Ahome"
    when "twitter"
      "site%3Atwitter.com"
    else
      ""
    end
    if !q or type == "SELECT"
      @flash = "you didn't provide valid input!"
      erb :index
    end
    url += "+#{q}"
    redirect url
end