class WorkspacesController < ApplicationController
  def new
  end

  def index
    api_key = params[:api_key]

    base_path = set_base_path(api_key: api_key)

    @workspaces = get_workspaces(base_path)
    @projects   = get_projects(base_path, @workspaces)



    workspace  = 27301307915813
    project    = 27329260245608
    @start_date = Date.new(2015,03,20)
    @end_date   = Date.new(2015,04,20)

    @tasks     = get_tasks(base_path, workspace, project, @start_date, @end_date)
    @report    = generate_report(@tasks)
  end
end
