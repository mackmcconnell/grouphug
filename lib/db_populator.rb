require_relative '../app/models/confession'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'active_record'


module DbPopulator
  def self.import
    hashes = YAML::load( File.read("yamldump.yaml") )

    ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => "#{File.dirname(__FILE__)}/../db/development.sqlite3")

    hashes.each do |user, text|
      Confession.create!( {:user => user, :text => text} )
    end
  end

  def self.scrape
    doc = Nokogiri::HTML(open('http://web.archive.org/web/20071025014638/http://grouphug.us/'))

    this_page_ids = doc.xpath('//h4/a').map do |link|
      link.content
    end

    this_page_texts = doc.xpath('//td/p').map do |text|
      text.content.lstrip.rstrip
    end

    hashes = Hash[ this_page_ids.zip(this_page_texts) ]

    File.open("yamldump.yaml", 'w') do |file|
      file << hashes.to_yaml
    end
  end
end
