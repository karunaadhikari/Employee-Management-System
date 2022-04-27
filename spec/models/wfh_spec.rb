# == Schema Information
#
# Table name: wfhs
#
#  id                :integer          not null, primary key
#  employee_id       :integer          not null
#  availability_from :datetime
#  availability_to   :time
#  reason            :text
#  status            :integer          default("0")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wfh, type: :model do
  let(:emp_1) { create :employee }
  let(:wfh_1) { create :wfh, employee_id: emp_1.id }

  # Basic Validations
  describe 'validations' do
    it { should validate_presence_of(:availability_from) }
    it { should validate_presence_of(:availability_to) }
    it { should validate_presence_of(:reason) }
    it { should validate_presence_of(:status) }
    it { should belong_to(:employee) }
  end

  describe 'one_of_the_following' do
    it do
      expect(wfh_1).to define_enum_for(:status).with_values(requested: 0, approved: 1, rejected: 2)
    end
  end
end
