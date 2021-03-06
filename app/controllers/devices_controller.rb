class DevicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_device_group
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :check_owner

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.where(device_group_id:params[:device_group_id])
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    @device.device_group = @device_group

    respond_to do |format|
      if @device.save
        format.html { redirect_to [@device_group, @device], notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: [@device_group, @device] }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    @device.device_group = @device_group

    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to [@device_group, @device], notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to device_group_devices_path, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    def set_device_group
      @device_group = DeviceGroup.find(params[:device_group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :gcm_id, :enabled)
    end

    def check_owner
      render json:{error: 'not found'}, :status => 422 if @device_group.user_id != current_user.id
    end
end
