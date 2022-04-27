# frozen_string_literal: true

# This task requires you to create a slack app with authorized scopes and generated bearer token
# in order to make it work.
# Birthday wish is sent to the employees to the deined CHANNEL_ID on their birthdays.

BIRTHDAY_WISH_QUOTE = 'Today, it\'s your birthday.
May the days ahead of you be filled with prosperity,
great health and above all joy in its truest
and purest form. Happy birthday!'

CHANNEL = ENV['CHANNEL']

namespace :birthday_message do
  desc 'Wish Happy Birthday on their birthdays'
  task wish_birthday: :environment do
    # Loop through all the kyc and obtain today's birthdays
    Kyc.today_birthdays.all.each do |kyc|
      # pass in (birthday wish quote, employees name, channel_id)
      SendBirthdayMessageJob.perform_now(BIRTHDAY_WISH_QUOTE, kyc.employee.full_name, CHANNEL)
    end
  end
end
