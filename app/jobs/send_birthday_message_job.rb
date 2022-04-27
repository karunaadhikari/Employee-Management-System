# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class SendBirthdayMessageJob < ApplicationJob
  def perform(message, name, channel_name)
    slack_webhook_url = 'https://slack.com/api/chat.postMessage'

    # Parse the url
    uri = URI.parse(slack_webhook_url)

    # Call Build Message
    request = build_message(uri, message, name, channel_name)

    # Call Send Message
    send_message(uri, request)
  end

  def build_message(uri, message, name, channel_name)
    request = Net::HTTP::Post.new(uri)

    # Add Bearer token to body
    request['Authorization'] = "Bearer #{ENV['SLACK_BOT_TOKEN']}"

    # Add text message
    request.body = "text=#{name}, #{message}"

    # Add channel name
    request.body += "&channel=#{channel_name}"

    request
  end

  def send_message(uri, request)
    # build req options
    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    # send request
    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
