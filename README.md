# Raspberyl Bot

Raspberyl is a Discord bot intended to provide trivia functionality to your Discord server. Powered by [discordrb](https://github.com/meew0/discordrb).

## Installation

Raspberyl is currently a private bot. You will need to create and run your own Discord app to add her to your server.

1. [Create a new Discord app](https://discordapp.com/developers/applications/me)
2. Click "Create a Bot User"
3. Insert your client ID into the following URL: `https://discordapp.com/oauth2/authorize?client_id=INSERT_CLIENT_ID_HERE&scope=bot&permissions=11264`
4. Follow the URL to add the bot to your server (requires the Manage Server permission)
5. `git clone https://github.com/mattantonelli/raspberyl-bot`
6. `cd raspberyl-bot`
7. `bundle install`
8. Set up the configuration file
    * `cp config/config.yml.example config/config.yml`
    * Updated the example values appropriately
9. `ruby run.rb`

## Permissions

Raspberyl requires the following permissions to work in a channel:

* Read Messages
* Send Messages
* Manage Messages

## Server Setup

1. Create a role called "Trivia Master" and assign it to whoever will be asking the questions
2. Create a Trivia text channel
    * Grant access to Raspberyl and whoever who will be asking/answering the questions
    * Copy the ID of this channel and set it in the configuration
3. Create a Trivia Answers text channel
    * Grant access to Raspberyl and the Trivia Master role
    * Copy the ID of this channel and set it in the configuration

## Deployment

Raspberyl is set up for [Capistrano](https://github.com/capistrano/capistrano) deployment. The deployment strategy is dependent on `rbenv` and `screen`. You can configure Raspberyl to deploy to your own server by updating `config/deploy.rb` and `config/deploy/production.rb` appropriately.

## Usage

After completing the Installation and Server Setup, Raspberyl will be ready to help you with your trivia!

When a user besides the Trivia Master posts in the Trivia channel, their answers will be deleted and copied to the Trivia Answers channel. This will ensure that only the Trivia Master can see the users' answers.
