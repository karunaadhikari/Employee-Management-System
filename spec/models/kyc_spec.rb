# == Schema Information
#
# Table name: kycs
#
#  id             :integer          not null, primary key
#  phone          :string
#  dob            :date
#  marital_status :integer
#  spouse_name    :string
#  spouse_phone   :string
#  spouse_email   :string
#  employee_id    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("0")
#

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kyc, type: :model do
  let(:emp_1) { create(:employee) }
  let(:kyc_1) { create(:kyc, employee_id: emp_1.id) }

  describe 'validations' do
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:marital_status) }
    it { should belong_to(:employee) }

    it 'is valid with valid attributes' do
      expect(kyc_1).to be_valid
    end
  end

  describe 'one_of_the_following' do
    # Marital Status has to be one of the following:
    it do
      expect(kyc_1).to define_enum_for(:marital_status).with_values(single: 0, married: 1, divorced: 2, widowed: 3)
    end

    # Status has to be one of the following:
    it do
      expect(kyc_1).to define_enum_for(:status).with_values(requested: 0, approved: 1, rejected: 2)
    end
  end
end
