$:.unshift(File.expand_path('../',  __FILE__)) unless $:.include?(File.expand_path('../',  __FILE__))
require 'rubygems'
require 'uri'
require 'video_parser/gateway'
require 'video_parser/video_site'
require 'video_parser/youku'
require 'video_parser/tudou'
require 'video_parser/slideshare'

# VideoParser support video site:
# * youku
# * tudou
# * slideshare
module VideoParser
  extend self
  # get video info from url
  #
  # video info include
  # * title
  # * thumbnail pic path
  # * video src
  def get(url, options = {})
    uri = URI.parse(auto_complete_url(url)) rescue nil
    video_site = get_video_site(uri)
    video_site && video_site.new(uri).get(options)
  end

  private
    def auto_complete_url(url)
      url =~ /^http/ ? url : "http://#{url}"
    end

    # uri is a URI instance
    def get_video_site(uri)
      return nil unless uri.is_a?(URI)
      return YouKu if uri.host == YouKu::VideoHost
      return TuDou if uri.host == TuDou::VideoHost
      return SlideShare if uri.host == SlideShare::VideoHost
    end

end
