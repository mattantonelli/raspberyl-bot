require 'rubygems'
require 'bundler/setup'
require 'ostruct'
require 'yaml'

Bundler.require(:default)

module RaspberylBot
  CONFIG = OpenStruct.new(YAML.load_file('config/config.yml'))

  logfile = File.open('log.txt', 'a')
  $stderr = logfile
  Discordrb::LOGGER.streams << logfile

  bot = Discordrb::Bot.new(token: CONFIG.token, client_id: CONFIG.client_id)

  TRIVIA_CHANNEL = bot.channel(CONFIG.trivia_channel)
  REVIEW_CHANNEL = bot.channel(CONFIG.review_channel)

  bot.ready do |event|
    server = bot.servers.values.first
    TRIVIA_MASTER = server.roles.find { |role| role.name.casecmp?('trivia master') }
  end

  bot.message do |event|
    next unless event.channel == TRIVIA_CHANNEL

    if event.author.role?(TRIVIA_MASTER)
      REVIEW_CHANNEL.send_message("__**Question: #{event.message.content}**__")
      TRIVIA_CHANNEL.send_message('You have 20 seconds to answer.')
      sleep(10)

      TRIVIA_CHANNEL.send_message('Only 10 seconds left!')
      sleep(10)

      TRIVIA_CHANNEL.send_message("*Time's up!*")
      REVIEW_CHANNEL.send_message("*Time's up!*")
    else
      event.message.delete
      REVIEW_CHANNEL.send_message("**#{event.author.display_name}:** #{event.message.content}")
    end

    nil
  end

  bot.run
end
