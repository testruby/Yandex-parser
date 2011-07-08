# encoding: UTF-8
require 'nokogiri'
require 'open-uri'

class Site  
  attr_accessor :site_domain
  attr_reader :words
  
  def self.create_for_test
    Site.new("колодцы под ключ", "колодцы", "рытье колодцев", "запрос", "frear.ru")
  end  
  
  def initialize (*words, site_domain)
    @words = *words
    @site_domain = site_domain
  end

  def show_site_domain
    @site_domain
  end

  def show_words
    @words.each { |word| puts word }
  end

  def add_words( *new_words )
    new_words.each { |word| @words << word unless @words.include?( word ) }
  end

  def delete_words( *words_to_delete )
    words_to_delete.each { |word| @words.delete( word ) }
  end

  def delete_all_words
    @words.clear
  end

  def change_word( word, new_word )
    i = @words.index( word ) if @words.include?( word )
    @words[i] = new_word
  end

  def xml_for_word( word )
    "http://xmlsearch.yandex.ru/xmlsearch?user=impulse221&key=03.3775144:b4483006febebfaa17af40f97c9c6e69&query=#{URI.escape(word)}&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1"
  end

  def parse
    @words.each do |word|
      doc = Nokogiri::XML(open(xml_for_word( word )))
      doc.css('url').each_with_index do |url, index|
        puts "#{index += 1}. #{word} - #{url.text}" if url.text =~ /#{self.site_domain}/
      end
    end
  end

  def parse_current
    @array = []
    @words.each do |word|
      doc = Nokogiri::XML(open(xml_for_word( word )))
      got_entry = doc.css('url').each_with_index.any? do |url, index|
        if url.text =~ /#{self.site_domain}/
          @array << "#{index += 1}. #{word} - #{url.text}"
          true
        end
      end
      @array << "-. #{word}" unless got_entry
    end
    return @array
  end

end
      




