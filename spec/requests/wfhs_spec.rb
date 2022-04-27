# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Wfh', type: :request do
  let!(:employee)                 { create(:employee) }
  let!(:wfh)                      { create(:wfh, employee_id: employee.id) }

  describe 'GET /new' do
    before { sign_in employee }

    it 'renders new template' do
      get new_wfh_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /index' do
    before { sign_in employee }

    it 'renders index template' do
      get wfhs_path
      expect(response).to render_template(:index)
    end

    it 'assigns @wfhs' do
      get wfhs_path
      expect(assigns(:wfhs)).to eq([wfh])
    end
  end

  describe 'GET /show' do
    before { sign_in employee }

    it 'renders the show template' do
      get wfh_path(wfh.id)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /create' do
    before { sign_in employee }

    context 'with valid attributes' do
      let!(:params) { attributes_for :wfh }

      it 'creates a new wfh application' do
        expect {
          post wfhs_path, params: {wfh: params}
        }.to change(Wfh, :count).by(1)
      end

      it 'redirects to wfhs_path' do
        post wfhs_path, params: {wfh: params}
        expect(response).to redirect_to wfhs_path
      end
    end

    context 'with invalid attributes' do
      let!(:invalid_params) { attributes_for :invalid_wfh }

      it "doesn't create a new wfh application" do
        expect {
          post wfhs_path, params: {wfh: invalid_params}
        }.to change(Wfh, :count).by(0)
      end

      it 'renders new template' do
        post wfhs_path, params: {wfh: invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    before { sign_in employee }

    it 'renders the edit page' do
      get edit_wfh_path(wfh.id)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT /update' do
    before { sign_in employee }

    context 'when attributes are valid' do
      let!(:update_params) { attributes_for :wfh, availability_from: '2022-02-13 20:10:00 +0545', availability_to: '2022-02-13 20:10:00 +0545' }
      let!(:params) { attributes_for :wfh }

      it 'updates the wfh application' do
        put wfh_path(wfh.id), params: {wfh: update_params}
        wfh.reload
        expect(wfh.availability_from).to eq('2022-02-13 20:10:00 +0545')
      end

      it 'redirects to wfhs_path' do
        put wfh_path(wfh.id), params: {wfh: params}
        expect(response).to redirect_to wfhs_path
      end
    end

    context 'when attributes are invalid' do
      let!(:invalid_update_params) { attributes_for :wfh, availability_from: '2022-02-13 20:10:00 +0545', availability_to: '2022-02-13 20:10:00 +0545', reason: '' }
      let!(:invalid_params) { attributes_for :invalid_wfh }

      it "doesn't updates the wfh application" do
        put wfh_path(wfh.id), params: {wfh: invalid_update_params}
        wfh.reload
        expect(wfh.availability_from).not_to eq('2022-02-13 20:10:00 +0545')
      end

      it 'renders the edit template' do
        put wfh_path(wfh.id), params: {wfh: invalid_params}
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE /destroy' do
    before { sign_in employee }

    it 'deletes the wfh application' do
      expect {
        delete wfh_path(wfh.id)
      }.to change(Wfh, :count).by(-1)
    end

    it 'redirects to wfhs_path' do
      delete wfh_path(wfh.id)
      expect(response).to redirect_to wfhs_path
    end
  end
end
