class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ edit update destroy ]
  before_action :set_language_choices, only: %i[ new edit update destroy create ]
  before_action :set_supervisor_employee_choices, only: %i[ new edit update destroy create ]
  before_action :set_unscoped_project, only: %i[ show restore ]

  

  # GET /projects or /projects.json
  def index
    if params[:query].present?
      @projects = search(params[:query], only_deleted_flag: false)
    else
      @projects = Project.all
    end
    @projects = @projects.page(params[:page])
  end

  # GET /projects/1 or /projects/1.json
  def show
    redirect_to action: "ghost" unless @project.is_deleted == false 
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def ghost 
    if params[:query].present?
      @projects = search(params[:query], only_deleted_flag: true)
    else
      @projects = Project.only_deleted
    end
    @projects = @projects.page(params[:page])
    render :index
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
      @language_choices = Language.all.pluck(:name, :id)
    end

    def search(q, options={only_deleted_flag: false})
      if options[:only_deleted_flag]
        Project.only_deleted.where("name LIKE ?", "%#{q}%")
      else
        Project.where("name LIKE ?", "%#{q}%")
      end
    end
    

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :body, :language_id, :supervisor_id)
    end
end
