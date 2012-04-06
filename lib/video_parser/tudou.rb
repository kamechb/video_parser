require 'video_parser/video_site'

module VideoParser
  # support path begin with "/playlist" or "/programs" format
  #
  class TuDou < VideoSite
    VideoHost = "www.tudou.com"
    attr_reader :is_playlist, :is_programs

    def self.embed_html(video_src)
      <<-EMBED
        <embed src = '#{video_src}' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' wmode='opaque' width='480' height='400'></embed>
      EMBED
    end

    private
      def extract_video_info
        return nil unless doc
        {:title => title, :video_src => video_src, :pic_path => pic_path}
      end

      def title
        doc.at_css("h1").inner_text rescue nil
      end

      def video_src
        if is_playlist?
          uri.path.match(/\/p\/l\d+i(\d+).*\.html/) ||
          uri.path.match(/[&#\?]iid=(\d+)/) ||
          uri.path.match(/\/p\/a\d+i(\d+).*\.html/)
          iid = $1
          lcode = get_lcode_from_script
          default_iid = get_default_iid_from_script
          iid ||= default_iid
          "http://www.tudou.com/l/#{lcode}/&iid=#{iid}/v.swf"
        elsif is_programs?
          uri.path =~ /view\/(.*?)\//
          lcode = $1
          "http://www.tudou.com/v/#{lcode}/v.swf"
        end
      end

      # pic in script content is:
      #
      # pic:"http://i4.tdimg.com/112/289/113/p.jpg"
      def pic_path
        if is_playlist?
          script_content =~ /pic:\s*?['"](.*?)['"]\s*?,/
        elsif is_programs?
          script_content =~ /pic\s*?=\s*?['"](.*?)['"]\s*?,/
        end
        $1
      end

      def is_playlist?
        uri.path =~ /\/playlist/
      end

      def is_programs?
        uri.path =~ /\/programs/
      end

      # lcode in script content is:
      #
      # lid_code = lcode = 'uQa8UQMbcWE'
      def get_lcode_from_script
        script_content =~ /lcode\s*?=\s*?['"](.*?)['"]/m
        $1
      end

      # defaultIid in script content is:
      #
      # defaultIid = 111370446,
      def get_default_iid_from_script
        script_content =~ /defaultIid\s*?=\s*?(\d+?)\s*?,/
        $1
      end

      def script_content
        @script_content ||= doc.at_css("script").content
      end
  end
end
