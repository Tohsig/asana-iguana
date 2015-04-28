class WorkspacesController < ApplicationController
  def index
    @api_key = params[:api_key]
    @workspaces = get_workspaces(@api_key)

    @projects   = get_projects(@api_key, 27301307915813)
    @tasks      = get_tasks(@api_key, 27329260245608)
    @users      = points_tally(@api_key, 27329260245608)
  end
end
