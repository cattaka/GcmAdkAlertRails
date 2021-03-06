class DeviceGroupsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_device_group, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:show, :edit, :update, :destroy]

  # GET /device_groups
  # GET /device_groups.json
  def index
    @device_groups = DeviceGroup.where(user_id:current_user.id).order(:name)
  end

  # GET /device_groups/1
  # GET /device_groups/1.json
  def show
  end

  # GET /device_groups/new
  def new
    @device_group = DeviceGroup.new
  end

  # GET /device_groups/1/edit
  def edit
  end

  # POST /device_groups
  # POST /device_groups.json
  def create
    @device_group = DeviceGroup.new(device_group_params)
    @device_group.user_id = current_user.id

    respond_to do |format|
      if @device_group.save
        format.html { redirect_to @device_group, notice: 'Device group was successfully created.' }
        format.json { render :show, status: :created, location: @device_group }
      else
        format.html { render :new }
        format.json { render json: @device_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_groups/1
  # PATCH/PUT /device_groups/1.json
  def update
    @device_group.user_id = current_user.id
    respond_to do |format|
      if @device_group.update(device_group_params)
        format.html { redirect_to @device_group, notice: 'Device group was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_group }
      else
        format.html { render :edit }
        format.json { render json: @device_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_groups/1
  # DELETE /device_groups/1.json
  def destroy
    @device_group.destroy
    respond_to do |format|
      format.html { redirect_to device_groups_url, notice: 'Device group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_group
      @device_group = DeviceGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_group_params
      params.require(:device_group).permit(:name, :exec_key)
    end

    def check_owner
      render json:{error: 'not found'}, :status => 422 if @device_group.user_id != current_user.id
    end
end
