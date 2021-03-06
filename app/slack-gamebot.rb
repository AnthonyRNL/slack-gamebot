require 'slack-gamebot/version'
require 'slack-gamebot/ascii'
require 'slack-gamebot/config'
require 'slack-gamebot/hooks'
require 'slack-gamebot/commands'
require 'slack-gamebot/app'
require 'models'

module SlackGamebot
  class << self
    def configure
      block_given? ? yield(Config) : Config
    end

    def config
      Config
    end
  end
end
