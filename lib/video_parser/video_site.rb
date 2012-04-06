require 'video_parser/gateway'

module VideoParser
  class VideoSite
    include GateWay
    attr_reader :uri, :doc

    def initialize(uri)
      @uri = uri
    end

    def get(options = {})
      @doc = get_doc(uri, options)
      extract_video_info
    end
    private
      def extract_video_info
        raise "This is a abstract class, you should implete this method in subclass!"
      end
  end
end
