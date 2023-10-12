class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  before_action :set_superior_employee_choices, only: %i[ new edit ]
  before_action :set_position_choices, only: %i[ new edit ]
  before_action :set_employment_status_choices, only: %i[ new edit ]
  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    

  end

  # GET /employees/1/edit
  def edit
    @superior_employee_choices = @superior_employee_choices.select{|s| s[1]!=@employee.id}
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
      @employee.touch
    end

    def set_superior_employee_choices
      @superior_employee_choices = Employee.where(positions: valid_positions_for_superiors_ids).collect {|e| [ e.first_name, e.id ] }
    end

    def set_position_choices
      @position_choices = Position.all.collect{|p| [ p.name, p.id ] }
    end
    def set_employment_status_choices
      @employment_status_choices = EmploymentStatus.all.collect{|es| [ es.name, es.id ] }
    end

    def valid_positions_for_superiors_ids
      positions = Position.where(super: true)
      positions.map { |pos| pos.id}
    end



    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:JMBG, :first_name, :last_name, :email, :address, :position_id, :employment_date, :superior_id, :employment_status_id)
    end
end
