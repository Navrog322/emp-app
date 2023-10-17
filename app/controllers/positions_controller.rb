class PositionsController < ApplicationController
  before_action :set_position, only: %i[ edit update destroy ]
  before_action :set_unscoped_position, only: %i[ show restore ]

  # GET /positions or /positions.json
  def index
    @positions = Position.all
  end

  # GET /positions/1 or /positions/1.json
  def show
    redirect_to action: "ghost" unless @position.is_deleted == false  
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
  end

  def ghost 
    @positions = Position.only_deleted
    render :index
  end

  def restore 
    @position.restore
    respond_to do |format|
      format.html { redirect_to position_ghost_url, notice: "position was successfully restored." }
    end
  end

  # POST /positions or /positions.json
  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        format.html { redirect_to position_url(@position), notice: "Position was successfully created." }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1 or /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to position_url(@position), notice: "Position was successfully updated." }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1 or /positions/1.json
  def destroy
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url, notice: "Position was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    def set_unscoped_position
      @position = Position.unscoped{Position.find(params[:id])}
    end

    # Only allow a list of trusted parameters through.
    def position_params
      params.require(:position).permit(:name, :super)
    end
end
