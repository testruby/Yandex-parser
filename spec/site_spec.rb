# encoding: UTF-8
require './site'

describe Site do
  before :each do
    @frear = Site.new( "колодцы", "септики", "водоснабжение", "frear.ru")
  end

  it 'should have the right number of words' do
    @frear.words.size.should == 3
  end

  it 'should add words' do
    @frear.add_words( "привет", "пока", "когда" )
    @frear.words.size.should == 6
  end

  it 'should delete a word' do
    @frear.delete_words( "колодцы", "септики" )
    @frear.words.should_not include( "колодцы", "септики" )
    @frear.words.size.should == 1
  end

  it 'should not add not unique word' do
    @frear.add_words( "колодцы", "септики" )
    @frear.words.size.should == 3
  end

  it 'should change the word' do
    @frear.change_word("колодцы", "новое слово")
    @frear.words.should_not include("колодцы")
    @frear.words.should include("новое слово")
  end

  it 'a word should have an xml_for_word' do
    @frear.xml_for_word( @frear.words.first ).should == "http://xmlsearch.yandex.ru/xmlsearch?user=impulse221&key=03.3775144:b4483006febebfaa17af40f97c9c6e69&query=#{URI.escape(@frear.words.first)}&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1"
  end

end






