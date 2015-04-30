class StaticPagesController < ApplicationController
  def home
    if session[:api_key]
      if !session[:api_key].empty?
        session[:api_key] = []
        flash.now[:info] = "API Key cleared from session"
      end
    else
      session[:api_key] = []
    end
  end
end
