class StaticPagesController < ApplicationController
  def home
    if !session[:api_key].empty?
      session[:api_key] = []
      flash.now[:info] = "API Key cleared from session"
    end
  end
end
