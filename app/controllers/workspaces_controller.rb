class WorkspacesController < ApplicationController
  def form
    @projects = []
    if session[:api_key].nil?
      api_key = params[:api_key]
      session[:api_key] = api_key
    else
      api_key = session[:api_key]
    end

    @base_path  = set_base_path(api_key)
    @projects   = get_projects(@base_path, @workspaces)

    if @projects == false
      redirect_to root_path
    end
  end

  def report
    api_key       = session[:api_key]
    base_path     = set_base_path(api_key)
    @project_id   = project_params[:id]
    @project_name = project_params[:name]

    if project_params[:start_date].nil?
      @start_date = Date.today - Date.today.wday
      @end_date   = Date.today
    else
      @start_date = Date.parse(project_params[:start_date])
      @end_date   = Date.parse(project_params[:end_date])
    end

    @tasks = get_tasks(base_path, @project_id, @start_date, @end_date)

    if @tasks
      @report = generate_report(@tasks)
    else
      @report = false
    end
  end

  private
    def project_params
      params.require(:project).permit(:id, :name, :start_date, :end_date)
    end
end
