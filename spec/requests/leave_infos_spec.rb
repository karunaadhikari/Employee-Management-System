# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let!(:employee) { create(:employee) }
  let!(:leave_info) { create(:leave_info) }

  describe 'GET /index' do
    before { sign_in employee }

    it 'assigns @leave_infos' do
      get leave_infos_path
      expect(assigns(:leave_infos)).to eq([leave_info])
    end

    it 'renders index template' do
      get leave_infos_path
      expect(response).to render_template(:index)
    end
  end
end
