# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'EmpLeaveInfo', type: :request do
  let!(:employee) { create(:employee) }
  let!(:leave_info) { create(:leave_info) }
  let!(:emp_leave_info) { create(:emp_leave_info, employee_id: employee.id, leave_info_id: leave_info.id) }

  describe 'GET /new' do
    before { sign_in employee }

    it 'renders new template' do
      get new_emp_leave_info_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /index' do
    before { sign_in employee }

    it 'renders index template' do
      get emp_leave_infos_path
      expect(response).to render_template(:index)
    end

    it 'assigns @emp_leave_infos' do
      get emp_leave_infos_path
      expect(assigns(:emp_leave_infos)).to eq([emp_leave_info])
    end
  end

  describe 'GET /show' do
    before { sign_in employee }

    it 'renders the show template' do
      get emp_leave_info_path(emp_leave_info.id)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /create' do
    before { sign_in employee }

    context 'with valid attributes' do
      let!(:params) { attributes_for(:emp_leave_info, leave_info_id: leave_info.id) }

      it 'creates a new emp_leave_info application' do
        expect {
          post emp_leave_infos_path, params: {emp_leave_info: params}
        }.to change(EmpLeaveInfo, :count).by(1)
      end

      it 'redirects to emp_leave_infos_path' do
        post emp_leave_infos_path, params: {emp_leave_info: params}
        expect(response).to redirect_to emp_leave_infos_path
      end
    end

    context 'with invalid attributes' do
      let!(:invalid_params) { attributes_for :invalid_emp_leave_info }

      it "doesn't create a new emp_leave_info application" do
        expect {
          post emp_leave_infos_path, params: {emp_leave_info: invalid_params}
        }.to change(EmpLeaveInfo, :count).by(0)
      end

      it 'renders new template' do
        post emp_leave_infos_path, params: {emp_leave_info: invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    before { sign_in employee }

    it 'renders the edit page' do
      get edit_emp_leave_info_path(emp_leave_info.id)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT /update' do
    before { sign_in employee }

    context 'when attributes are valid' do
      let!(:update_params) { attributes_for :emp_leave_info, date_from: Time.zone.yesterday, date_to: Time.zone.today }
      let!(:params) { attributes_for :emp_leave_info }

      it 'updates the emp_leave_info application' do
        put emp_leave_info_path(emp_leave_info.id), params: {emp_leave_info: update_params}
        emp_leave_info.reload
        expect(emp_leave_info.date_from).to eq(Date.yesterday)
      end

      it 'redirects to emp_leave_infos_path' do
        put emp_leave_info_path(emp_leave_info.id), params: {emp_leave_info: params}
        expect(response).to redirect_to emp_leave_infos_path
      end
    end

    context 'when attributes are invalid' do
      let!(:invalid_update_params) { attributes_for :emp_leave_info, date_from: '2022-01-01', date_to: '2022-02-14', reason: '' }
      let!(:invalid_params) { attributes_for :invalid_emp_leave_info }

      it "doesn't updates the emp_leave_info application" do
        emp_leave_info = create(:emp_leave_info)
        put emp_leave_info_path(emp_leave_info.id), params: {emp_leave_info: invalid_update_params}
        emp_leave_info.reload
        expect(emp_leave_info.date_from).not_to eq('2022-01-01')
      end

      it 'renders the edit template' do
        put emp_leave_info_path(emp_leave_info.id), params: {emp_leave_info: invalid_params}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    before { sign_in employee }

    it 'deletes the emp_leave_info application' do
      expect {
        delete emp_leave_info_path(emp_leave_info.id)
      }.to change(EmpLeaveInfo, :count).by(-1)
    end

    it 'redirects to emp_leave_infos_path' do
      delete emp_leave_info_path(emp_leave_info.id)
      expect(response).to redirect_to emp_leave_infos_path
    end
  end
end
