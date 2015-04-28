class WorkspacesController < ApplicationController
  def form
    api_key = params[:api_key]
    session[:api_key] = api_key
    base_path = set_base_path(api_key)

    @workspaces = get_workspaces(base_path)
    @projects   = get_projects(base_path, @workspaces)
  end

  def report
    api_key     = session[:api_key]
    base_path   = set_base_path(api_key)
    workspace   = 27301307915813
    project     = 27329260245608
    @start_date = Date.new(2015,03,20)
    @end_date   = Date.new(2015,04,20)

    @tasks     = get_tasks(base_path, workspace, project, @start_date, @end_date)
    @report    = generate_report(@tasks)
  end
end
