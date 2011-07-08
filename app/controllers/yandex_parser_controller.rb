class YandexParserController < ApplicationController

  def index
  end

  def show
    @site_domain = params[:site_domain]
    @words = params[:words].split("\r\n")
    @frear = Site.new(*@words, @site_domain)
    @array = @frear.parse_current
  end

end
