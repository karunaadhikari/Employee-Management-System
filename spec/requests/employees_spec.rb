# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let!(:employee) { create(:employee) }
  let!(:kyc) { create(:kyc, employee_id: employee.id) }

  describe 'GET /index' do
    before { sign_in employee }

    it 'assigns @employees' do
      get employees_path
      expect(assigns(:employees)).to eq([employee])
    end

    it 'renders index template' do
      get employees_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /index with search params' do
    before { sign_in employee }

    let(:query) { employee.fname }
    let(:q) { employee.lname }
    let(:search_result) { doubles 'search_result' }

    it 'returns search result first name if record found' do
      get employees_path, params: {term: query}
      expect(assigns(:employees)).to eq([employee])
    end

    it 'returns [] if record not found' do
      get employees_path, params: {term: ''}
      expect(assigns(:employees)).to eq([])
    end

    it 'returns search result last name if record found' do
      get employees_path, params: {term: q}
      expect(assigns(:employees)).to eq([employee])
    end
  end

  describe 'GET /show' do
    before { sign_in employee }

    it 'assigns @employee' do
      get employee_path(employee)
      expect(assigns(:employee)).to eq(employee)
    end

    it 'assigns @kyc' do
      get employee_path(employee)
      expect(assigns(:kyc)).to eq(kyc)
    end
  end
end
