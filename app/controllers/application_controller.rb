class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  # skip_before_action :authenticate_user, only: :create

  private

    def authenticate_user
      # make sure to pass in the scope parameter (`repo` scope should be appropriate for what we want to do) in step of the auth process!
      # https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/#web-application-flow
      client_id = ENV['CLIENT_ID']
      redirect_uri = CGI.escape("http://localhost:3000/auth")
      git_link = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo&state=aeionf043fna"
      
      redirect_to git_link unless logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
