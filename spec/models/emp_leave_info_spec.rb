# == Schema Information
#
# Table name: emp_leave_infos
#
#  id            :integer          not null, primary key
#  reason        :text
#  leave_info_id :integer          not null
#  employee_id   :integer          not null
#  date_from     :date
#  date_to       :date
#  status        :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmpLeaveInfo, type: :model do
  let(:emp_1) { create(:employee) }
  let(:leave_info_1) { create(:leave_info) }
  let(:emp_leave_info_1) { create(:emp_leave_info, employee_id: emp_1.id, leave_info_id: leave_info_1.id) }

  # Basic Validations
  describe 'validations' do
    it { should validate_presence_of(:reason) }
    it { should validate_presence_of(:date_from) }
    it { should validate_presence_of(:status) }
    it { should belong_to(:leave_info) }
    it { should belong_to(:employee) }
  end

  describe 'one_of_the_following' do
    # Status has to be one of the following:
    it do
      expect(emp_leave_info_1).to define_enum_for(:status).with_values(requested: 0, approved: 1, rejected: 2)
    end
  end
end
