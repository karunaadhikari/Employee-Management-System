# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kycs', type: :request do
  let!(:emp_with_kyc) { create(:employee) }
  let!(:emp_without_kyc) { create(:employee) }
  let!(:kyc) { create(:kyc, employee_id: emp_with_kyc.id) }
  let(:kyc_attrs) { attributes_for :kyc }

  context 'when employee has kyc' do
    before { sign_in emp_with_kyc }

    it 'renders edit page' do
      get edit_kyc_path(kyc.id)
      expect(response).to be_successful
    end

    it 'redirects to edit page when he/she tries to visit new page' do
      get new_kyc_path
      expect(response).to redirect_to(edit_kyc_path(kyc.id))
    end
  end

  context 'when employee doesn\'t have kyc' do
    before { sign_in emp_without_kyc }
    # Test Create Method

    describe 'create kyc' do
      let(:kyc_attrs) { attributes_for :kyc }

      it 'saves the model' do
        expect {
          post kyc_path, params: {kyc: kyc_attrs}
        }.to change(Kyc, :count).by(1)
      end
    end

    it 'renders new page' do
      get new_kyc_path
      expect(response).to be_successful
    end
  end
end
