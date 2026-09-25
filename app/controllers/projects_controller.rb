class ProjectsController < ApplicationController
  before_action :authenticate_admin!, except: %i[ index show ]
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :ensure_visible!, only: %i[ show ]

  # GET /projects or /projects.json
  def index
    @projects = if admin_signed_in?
      Project.all.order(published_at: :desc, created_at: :desc).includes(:technologies)
    else
      Project.published.includes(:technologies)
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to safe_redirect_target(admin_path), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @project.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to safe_redirect_target(admin_path), notice: "Project was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @project.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to safe_redirect_target(projects_path), notice: "Project was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by!(slug: params.expect(:id))
    end

    # Drafts are only visible to the signed-in admin previewing them.
    def ensure_visible!
      raise ActiveRecord::RecordNotFound unless @project.published? || admin_signed_in?
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.expect(project: [ :title, :description, :slug, :published, :image, :github_url, :demo_url, :technology_list,
        features_attributes: [ [ :id, :title, :description, :image, :position, :_destroy ] ] ])
    end
end
