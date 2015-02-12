require 'twitter'

# Read the config file
tw = eval(File.open(File.expand_path('config_postgresql.rb')).read)

twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = tw['tw_consumer_key']
  config.consumer_secret = tw['tw_consumer_secret']
  config.access_token = tw['tw_access_token']
  config.access_token_secret = tw['tw_access_token_secret']
end

search_term = URI::encode('#PostgreSQL')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
    # there's no need to continue
    job.unschedule
  end
end
