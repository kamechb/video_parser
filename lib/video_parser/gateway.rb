require 'iconv'
require 'nokogiri'
require 'httparty'

module GateWay
  def get_doc(uri, options = {})
    options[:timeout] ||= 20
    begin
      page = HTTParty.get(uri.to_s, :timeout => options[:timeout]).to_s
      Nokogiri::HTML(conv_page(page))
    rescue
      nil
    end
  end

  private
    def conv_page(page)
      charset = get_charset(page)
      if charset && !['UTF8', 'utf8', 'UTF-8', 'utf-8'].include?(charset)
        conved_page = Iconv.conv('UTF-8', charset, page)
      end

      conved_page || page
    end

    def get_charset(page)
      page =~ /charset\s*?=\s*?['"]?([^'"]*)['"]?/
      $1
    end
end
