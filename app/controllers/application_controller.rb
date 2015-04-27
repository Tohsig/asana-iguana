class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_workspaces(api_key)
    path = RestClient::Resource.new('https://app.asana.com/api/1.0/workspaces', user: api_key, password: '')
    workspaces = path.get
    JSON.parse(workspaces)
  end

  def get_projects(api_key, workspace_id)
    path = RestClient::Resource.new("https://app.asana.com/api/1.0/workspaces/#{workspace_id}/projects", user: api_key, password: '')
    projects = path.get
    JSON.parse(projects)
  end

  def get_tags
  end
end
