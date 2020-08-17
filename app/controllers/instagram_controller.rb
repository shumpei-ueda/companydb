class InstagramController < ApplicationController
  require 'selenium-webdriver'
  require 'uri'

  def new
  end
  def like
    user_name =params[:account_name]
    password = params[:password]
    bot = Instagram::InstagramService.new(user_name,password)
    key_word = params[:key_word]
    count = params[:count].to_i
    if count >50
      count = 50
    end
    bot.good_and_follow(key_word,count)
    render("instagram/new")
  end






end
