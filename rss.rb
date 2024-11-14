require 'rss'
require 'json'
require 'open-uri'

class RSSUpdater
  def initialize(feeds, output_file = 'rss_feed.json', interval = 1800)
    @feeds = feeds
    @output_file = output_file
    @interval = interval
  end

  def start_auto_update
    loop do
      puts "Starting RSS update at #{Time.now}"
      update_feeds
      puts "Waiting #{@interval / 60} minutes for the next update..."
      sleep @interval
    end
  end

  private

  def update_feeds
    all_feed_data = @feeds.map { |feed_url| fetch_feed_data(feed_url) }.compact
    save_to_file(all_feed_data)
    puts "Feeds updated and saved to #{@output_file}."
  end

  def fetch_feed_data(url)
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      {
        title: feed.channel.title,
        link: feed.channel.link,
        description: feed.channel.description,
        items: feed.items.map do |item|
          {
            title: item.title,
            link: item.link,
            pub_date: item.pubDate,
            description: item.description
          }
        end
      }
    rescue StandardError => e
      puts "Error fetching #{url}: #{e.message}"
      nil
    end
  end

  def save_to_file(data)
    File.write(@output_file, JSON.pretty_generate(data))
  end
end

feeds = [
  'https://feeds.ign.com/ign/all',
  'https://www.gamespot.com/feeds/news/',
  'https://blog.playstation.com/feed/',
  'https://news.xbox.com/en-us/feed/'
]

updater = RSSUpdater.new(feeds, 'rss_feed.json', 1800)
updater.start_auto_update
