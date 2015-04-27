class WorkspacesController < ApplicationController

  def index
    @api_key = params[:api_key]
    @workspaces = get_workspaces(@api_key)
    @workspaces = @workspaces['data']

    @projects = get_projects(@api_key, 27301307915813)
  end
end
