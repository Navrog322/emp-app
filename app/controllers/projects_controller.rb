class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ edit update destroy ]
  before_action :set_language_choices, only: %i[ new edit update create] 
  before_action :set_langugage_choices_with_default, only: %i[ index show restore ghost ]
  before_action :set_supervisor_employee_choices, only: %i[ new edit update destroy create ]
  before_action :set_unscoped_project, only: %i[ show restore ]

  

  # GET /projects or /projects.json
  def index
    data = {name: is_like(params[:name]), body: is_like(params[:body])} 
    @projects = search(data, {only_deleted_flag: false})
    if params[:language_id].present?
      @projects = @projects.where("language_id = ?", params[:language_id])
    end
    @projects = @projects.page(params[:page])
    if turbo_frame_request? 
      render partial: "projects", locals:{ projects: @projects }
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
    redirect_to action: "ghost" if @project.is_deleted
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def ghost 
    data = {name: is_like(params[:name]), body: is_like(params[:body])} 
    @projects = search(data, {only_deleted_flag: true})
    if params[:language_id].present?
      @projects = @projects.where("language_id = ?", params[:language_id])
    end
    @projects = @projects.page(params[:page])
    if turbo_frame_request? 
      render partial: "projects", locals:{ projects: @projects }
    else
      render :index
    end
  end

  def restore 
    @project.restore
    respond_to do |format|
      format.html {redirect_to project_ghost_url, notice: "Project was successfully restored."} 
    end
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    

  

  private

  
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_unscoped_project
      @project = Project.unscoped{Project.find(params[:id])}
    end

    def set_supervisor_employee_choices
      @supervisor_employee_choices = Employee.all.map{|e| [helpers.full_name(e), e.id]}
    end

    def set_language_choices
      @language_choices = Language.pluck(:name, :id)
    end

    def set_langugage_choices_with_default
      @language_choices = Language.pluck(:name, :id).prepend(["---Choose a language---", ""])
    end

    def search data, options={only_deleted_flag: false}
      if options[:only_deleted_flag]
        Project.only_deleted.where(["name LIKE :name and body LIKE :body", data])
      else
        Project.where(["name LIKE :name and body LIKE :body", data])
      end
    end
    

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :body, :language_id, :supervisor_id)
    end
end
