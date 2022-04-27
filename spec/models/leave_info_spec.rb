# == Schema Information
#
# Table name: leave_infos
#
#  id           :integer          not null, primary key
#  uid          :string
#  kind         :integer
#  default_days :integer
#  description  :text
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeaveInfo, type: :model do
  let(:leave_info) { create(:leave_info) }

  # Basic Validations
  describe 'validations' do
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:default_days) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should have_many(:emp_leave_infos) }

    it 'is valid with valid attributes' do
      expect(leave_info).to be_valid
    end

    describe 'one_of_the_following' do
      # Kind has to be one of the following:
      it do
        expect(leave_info).to define_enum_for(:kind).with_values(sick: 0, paid: 1, maternity: 2, paternity: 3, kriya: 4, other: 5)
      end

      # Status has to be one of the following:
      it 'has inactive and active statuses' do
        expect(leave_info).to define_enum_for(:status).with_values(inactive: 0, active: 1)
      end
    end
  end
end
