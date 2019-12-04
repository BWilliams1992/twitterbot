# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :tweets do
  desc "Sends a tweet"
  task :send_tweet_test => :environment do
    @twitbot = Twitbot.first

    @client = @twitbot.user.twitter_client
    @client.update("Tweeted using a rake task")
  end

  desc "Sends a random tweet from the twitterbot that hasnt been sent before"
  task :send_tweet => :environment do
    @twitbots = Twitbot.all
    @twitbots.each do |twitbot|
      @unsent = twitbot.unsent

      @selector = rand(@unsent.length)
      twitbot.user.twitter_client.update(@unsent[@selector].content)

      twitbot.tweets.each do |tweet|
        if @unsent[@selector] == tweet
          tweet.used = true
          tweet.save
        else
          next
        end
      end
    end
  end

end
