class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_workspaces(api_key)
    resource = RestClient::Resource.new('https://app.asana.com/api/1.0/workspaces',
                                    user: api_key, password: '')
    workspaces = resource.get
    JSON.parse(workspaces)['data']
  end

  def get_projects(api_key, workspace_id)
    resource = RestClient::Resource.new("https://app.asana.com/api/1.0/workspaces/#{workspace_id}/projects",
                                    user: api_key, password: '')
    projects = resource.get
    JSON.parse(projects)['data']
  end

  def get_tasks(api_key, project_id)
    resource = RestClient::Resource.new("https://app.asana.com/api/1.0/projects/#{project_id}/tasks",
                                user: api_key, password: '')
    tasks = resource['?opt_fields=name,assignee,completed'].get
    JSON.parse(tasks)['data']
  end

  def points_tally(api_key, project_id)
    tasks = get_tasks(api_key, project_id)
    users = collect_users(api_key, tasks)
    return users
  end

  def collect_users(api_key, tasks)
    users = []
    tasks.each do |task|
      if task['completed'] == true
        users << task['assignee']
      end
    end
    users.uniq!
    users.each do |user|
      if user != nil
        user[:name] = find_user_name(api_key, user['id'])
      end
    end
    users
  end

  def find_user_name(api_key, user_id)
    resource = RestClient::Resource.new("https://app.asana.com/api/1.0/users/#{user_id}",
                                    user: api_key, password: '')
    user = resource.get
    user = JSON.parse(user)['data']
    user['name']
  end
end
