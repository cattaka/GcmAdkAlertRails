class CommandsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_device_group
  before_action :set_command, only: [:show, :edit, :update, :destroy]

  # GET /commands
  # GET /commands.json
  def index
    @commands = Command.all
  end

  # GET /commands/1
  # GET /commands/1.json
  def show
  end

  # GET /commands/new
  def new
    @command = Command.new
  end

  # GET /commands/1/edit
  def edit
  end

  # POST /commands
  # POST /commands.json
  def create
    @command = Command.new(command_params)
    @command.device_group = @device_group

    respond_to do |format|
      if @command.save
        format.html { redirect_to [@device_group,@command], notice: 'Command was successfully created.' }
        format.json { render :show, status: :created, location: [@device_group,@command] }
      else
        format.html { render :new }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commands/1
  # PATCH/PUT /commands/1.json
  def update
    @command.device_group = @device_group

    respond_to do |format|
      if @command.update(command_params)
        format.html { redirect_to [@device_group,@command], notice: 'Command was successfully updated.' }
        format.json { render :show, status: :ok, location: [@device_group,@command] }
      else
        format.html { render :edit }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commands/1
  # DELETE /commands/1.json
  def destroy
    @command.destroy
    respond_to do |format|
      format.html { redirect_to device_group_commands_url(@device_group), notice: 'Command was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    def set_device_group
      @device_group = DeviceGroup.find(params[:device_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def command_params
      params.require(:command).permit(:actions_json, :exec_key)
    end
end
