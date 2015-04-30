class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_base_path(api_key)
    RestClient::Resource.new('https://app.asana.com/api/1.0/',
                                    user: api_key, password: '')
  end

  def convert_to_json(hash)
    JSON.parse(hash)['data']
  end

  def get_projects(base_path, workspaces)
    begin
      projects = base_path['projects?opt_fields=name,workspace.name,team.name&archived=false'].get
    rescue => e
      case
      when e.message.include?("401")
        flash[:danger] = "Sorry, Asana doesn't recognize that API key."
      else
        flash[:danger] = "Sorry, we seem to be having trouble contacting Asana.\nTry again later!"
      end
      return false
    end
    convert_to_json(projects)
  end

  def get_tasks(base_path, project, start_date, end_date)
    tasks = []
    begin
      tasks = base_path["projects/#{project}/tasks?opt_fields=tags.name,assignee.name,completed_at&completed_since=#{start_date.to_time.iso8601}"].get
    rescue => e
      flash.now[:danger] = "Sorry, something went wrong. Please try again."
    end

    tasks.empty? ? false : tasks = convert_to_json(tasks)
    tasks.empty? ? false : tasks = trim_end_date(tasks, end_date)
    tasks.empty? ? false : tasks = remove_extra_tags(tasks)
    tasks.empty? ? false : tasks = fix_unassigned(tasks)
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
