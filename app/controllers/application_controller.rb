class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_base_path(api_key)
    RestClient::Resource.new('https://app.asana.com/api/1.0/workspaces',
                                    user: api_key, password: '')
  end

  def convert_to_json(hash)
    JSON.parse(hash)['data']
  end

  def get_workspaces(base_path)
    workspaces = base_path.get
    convert_to_json(workspaces)
  end

  def get_projects(base_path, workspaces)
    all_projects = {}
    workspaces.each do |workspace|
      projects = base_path["/#{workspace['id']}/projects"].get
      projects = convert_to_json(projects)
      all_projects[workspace['id']] = projects
    end
    all_projects
  end

  def get_tasks(base_path, workspace, project, start_date, end_date)
    tasks = base_path["/#{workspace}/tasks?project=#{project}&opt_fields=tags.name,assignee.name,completed_at&completed_since=#{start_date.to_time.iso8601}"].get
    tasks = convert_to_json(tasks)
    tasks = trim_end_date(tasks, end_date)
    tasks = remove_extra_tags(tasks)
    tasks = fix_unassigned(tasks)
  end

  def trim_end_date(tasks, end_date)
    tasks.select! { |task| task['completed_at'] != nil }
    tasks.select { |task| Date.parse(task['completed_at']) <= end_date }
  end

  def remove_extra_tags(tasks)
    tasks.each do |task|
      task['tags'].select! { |key, value| key['name'].to_i > 0 }
    end
    tasks.select! { |task| !task['tags'].empty? }
  end

  def fix_unassigned(tasks)
    tasks.each do |task|
      if task['assignee'].nil?
        task['assignee'] = {}
        task['assignee']['name'] = "Unassigned"
      end
    end
  end

  def generate_report(tasks)
    gather_points(tasks)
  end

  def gather_points(tasks)
    points = {}
    tasks.each do |task|
      if points[task['assignee']['name']].nil?
        points[task['assignee']['name']] = []
      end
      points[task['assignee']['name']] << task['tags'].first['name'].to_i
    end
    points
  end
end
