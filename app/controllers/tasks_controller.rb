class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_project_choices, only: %i[ new edit update destroy create ]
  before_action :set_employee_choices, only: %i[ new edit update destroy create ]
  before_action :set_unscoped_task, only: %i[ show restore ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.page(params[:page]) 
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    redirect_to action: "ghost" unless @task.is_deleted == false 
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  def ghost 
    @tasks = Task.only_deleted.page(params[:page]) 
    render :index 
  end

  def restore 
    @task.restore
    respond_to do |format|
    format.html {redirect_to task_ghost_url, notice: "Task was successfully restored."} 
    end
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_unscoped_task
      @task = Task.unscoped{Task.find(params[:id])}
    end

    def set_project_choices
      @project_choices = Project.pluck(:name, :id)
    end

    def set_employee_choices
      @employee_choices = Employee.all.map{|e| [helpers.full_name(e), e.id]}
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :body, :is_completed, :project_id, :employee_id)
    end
end
