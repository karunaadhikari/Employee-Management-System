# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Kycs', type: :request do
  let!(:emp) { create(:employee) }
  let!(:today_birthdays) { create(:today_birthdays) }
  let!(:upcoming_birthdays) { create(:kyc) }

  describe 'when employee visits birthday page' do
    before { sign_in emp }

    it 'renders index page' do
      get birthdays_path
      expect(response).to render_template(:index)
    end

    it 'assigns @today_birthdays' do
      get birthdays_path
      expect(assigns(:today_birthdays)).to eq([today_birthdays])
    end

    it 'assigns @upcoming_birthdays' do
      get birthdays_path
      expect(assigns(:upcoming_birthdays)).to eq([today_birthdays, upcoming_birthdays])
    end
  end
end
