# frozen_string_literal: true

class KycsController < ApplicationController
  before_action :approved!, only: [:update]

  def new
    if current_employee.kyc.present?
      redirect_to edit_kyc_path(current_employee.kyc.id)
    else
      @kyc = Kyc.new
    end
  end

  def edit
    if current_employee.kyc.nil?
      flash[:alert] = 'You need to create Kyc first.'
      redirect_to new_kyc_path
    end
    @kyc = current_employee.kyc
  end

  def create
    @kyc = Kyc.new(kyc_params)
    @kyc.employee_id = current_employee.id

    respond_to do |format|
      if @kyc.save
        format.html { redirect_to root_path, notice: 'Your kyc has been sent for review.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @kyc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @kyc = current_employee.kyc

    respond_to do |format|
      if @kyc.update(kyc_params)
        format.html { redirect_to root_path, notice: 'Kyc was successfully updated.' }
        format.json { render :show, status: :accepted }
      else
        format.html { render :edit }
        format.json { render json: @kyc.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def kyc_params
    params.require(:kyc).permit(:phone, :dob, :marital_status, :spouse_name, :spouse_phone, :spouse_email)
  end

  def approved!
    @kyc = current_employee.kyc

    return unless @kyc.approved?

    flash[:alert] = 'Permission not sufficient'
    redirect_to root_path
  end
end
