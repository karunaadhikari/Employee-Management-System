# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  let!(:employee) { create(:employee) }
  let!(:today_leave_emp) { create(:today_leave_emp) }
  let!(:today_wfh_emp) { create(:today_wfh_emp) }

  describe 'GET /index' do
    before { sign_in employee }

    it 'renders new template' do
      get today_leaves_path
      expect(response).to render_template(:index)
    end

    it 'assigns @today_leaves' do
      get today_leaves_path
      expect(assigns(:today_leaves)).to eq([today_leave_emp])
    end

    it 'assigns @today_wfhs' do
      get today_leaves_path
      expect(assigns(:today_wfhs)).to eq([today_wfh_emp])
    end
  end
end
