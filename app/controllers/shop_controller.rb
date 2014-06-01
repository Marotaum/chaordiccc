class ShopController < ApplicationController
  def index
    #render :text => get_items
    items           = get_items['data']
    @widget         = items['widget']
    @reference      = items['reference']
    @recommendation = items['recommendation']
  end

  protected
    def get_items
      require 'open-uri'
      require 'json'

      if Rails.env.production?
        file   = open('http://roberval.chaordicsystems.com/challenge/challenge.json?callback=X')
      else
        file   = open("#{Rails.root}/external/contents.txt")
      end
      contents = file.read.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
      contents = contents[2,contents.size]
      contents = contents.gsub('});','}')
      contents = JSON.parse(contents)

      return contents
    end

end
