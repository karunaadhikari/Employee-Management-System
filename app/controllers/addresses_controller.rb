# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  before_action :require_permission, only: %i[edit update destroy show]
  def new
    @address = Address.new
  end

  def create
    @address = current_employee.addresses.create(address_params)
    if @address.valid?
      flash[:notice] = 'Your Address information is submitted!'
      redirect_to addresses_path
    else
      flash[:alert] = 'Woops! Looks like there has been an error!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @address.update(address_params)
    if @address.valid?
      flash[:notice] = 'Your Address information has been updated!'
      redirect_to addresses_path
    else
      flash[:alert] = 'Woops! Looks like there has been an error!'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @addresses = current_employee.addresses.order('created_at DESC')
  end

  def show; end

  def destroy
    @address.destroy
    flash[:notice] = 'The information was successfully deleted!'
    redirect_to addresses_path
  end

  private

  def require_permission
    return unless @address.employee != current_employee

    redirect_to root_path, flash: {alert: 'You do not have permission to do that.'}
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:country, :state, :district, :city, :street, :house_no, :kind)
  end
end
