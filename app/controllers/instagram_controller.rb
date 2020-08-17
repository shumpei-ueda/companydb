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
    count = params[:count].present? ? params[:count].to_i : 10
    follower = params[:follower].present? ? params[:follower].to_i : 1000
    if count >50
      count = 50
    end
    bot.good_and_follow(key_word,count,follower)
    render("instagram/new")
  end






end
