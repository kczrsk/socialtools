require 'twitter'

desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."

  client = config

  {:brasil => 23424768, :sp => 455827}.each do |local|

  puts "Trend Topics: #{local[0]}" 
  
    client.trends(local[1]).each do |t|
      puts t.name

      if t.name.include?('Audax') || t.name.include?('timbeta')
        puts "ACHOU!!!! - "
        send_tweet(client, t.name)
      end   

    end

    puts "______________"

  end 

  puts "done."
end



# CONFIG
# ==========================================
def config
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "1AzbrpeeT0DEf0oG8C6wA"
    config.consumer_secret     = "lJU9ClRcpFxlaPhoGr7HQuBA5PyKJYIFg5f8Apn3tw"
    config.access_token        = "2203424671-CUiTwUG0GUmIJlFCeVveb7Q5MHlt0D3qMVtQLkC"
    config.access_token_secret = "TQY7iPBEeBQsdl2Y4ajDfhGLcuRjFdYJWYMAWUXe3lFC2"
  end

  client
end

# SEND TWEET
# ==========================================
def send_tweet(client, name)
  puts "Tweet enviado para @thiago_kazu"
  client.update("@thiago_kazu Alerta! [#{name}] está no TT #{Time.now}" )
end
