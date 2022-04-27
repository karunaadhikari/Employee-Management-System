# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  let!(:employee) { create(:employee) }
  let!(:address) { create(:address, employee_id: employee.id) }

  describe 'GET /new' do
    before { sign_in employee }

    it 'renders new template' do
      get new_address_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /index' do
    before { sign_in employee }

    it 'renders index template' do
      get addresses_path
      expect(response).to render_template(:index)
    end

    it 'assigns @addresses' do
      get addresses_path
      expect(assigns(:addresses)).to eq([address])
    end
  end

  describe 'GET /show' do
    before { sign_in employee }

    it 'renders the show template' do
      get address_path(address.id)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /create' do
    before { sign_in employee }

    context 'with valid attributes' do
      let!(:params) { attributes_for :address }

      it 'creates a new address' do
        expect {
          post addresses_path, params: {address: params}
        }.to change(Address, :count).by(1)
      end

      it 'redirects to addresses_path' do
        post addresses_path, params: {address: params}
        expect(response).to redirect_to addresses_path
      end
    end

    context 'with invalid attributes' do
      let!(:invalid_params) { attributes_for :invalid_address }

      it "doesn't create a new address" do
        expect {
          post addresses_path, params: {address: invalid_params}
        }.to change(Address, :count).by(0)
      end

      it 'renders new template' do
        post addresses_path, params: {address: invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    before { sign_in employee }

    it 'renders the edit page' do
      get edit_address_path(address.id)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT /update' do
    before { sign_in employee }

    context 'when attributes are valid' do
      let!(:update_params) { attributes_for :address, country: 'Afghanistan' }
      let!(:params) { attributes_for :address }

      it 'updates the address information' do
        put address_path(address.id), params: {address: update_params}
        address.reload
        expect(address.country).to eq('Afghanistan')
      end

      it 'redirects to addresses_path' do
        put address_path(address.id), params: {address: params}
        expect(response).to redirect_to addresses_path
      end
    end

    context 'when attributes are invalid' do
      let!(:invalid_update_params) { attributes_for :address, country: 'Nepal', kind: '' }
      let!(:invalid_params) { attributes_for :invalid_address }

      it "doesn't updates the address application" do
        put address_path(address.id), params: {address: invalid_update_params}
        address.reload
        expect(address.country).not_to eq('Nepal')
      end

      it 'renders the edit template' do
        put address_path(address.id), params: {address: invalid_params}
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE /destroy' do
    before { sign_in employee }

    it 'deletes the address information' do
      expect {
        delete address_path(address.id)
      }.to change(Address, :count).by(-1)
    end

    it 'redirects to addresses_path' do
      delete address_path(address.id)
      expect(response).to redirect_to addresses_path
    end
  end
end
