module Notification
  extend ActiveSupport::Concern

  def slack_notify(text, channel)
    require 'slack-notifier'
    notifier = Slack::Notifier.new( ENV["SLACK_INCOMING_URL"],
                                    username: "Wiki bot",
                                    icon_url: "https://www.eff.org/files/FPG_icon_Wikileaks.png")
    notifier.channel = channel
    notifier.ping text, unfurl_links: true
  end
end
