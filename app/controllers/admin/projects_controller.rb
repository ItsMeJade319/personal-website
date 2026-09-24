class Admin::ProjectsController < Admin::BaseController
  def index
    @projects = Project.order(created_at: :desc)
  end
end
