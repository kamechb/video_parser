require 'video_parser/video_site'

module VideoParser
  class YouKu < VideoSite
    VideoHost = "v.youku.com"

    def self.embed_html(video_src)
      <<-EMBED
        <embed src='#{video_src}' quality='high' width='480' height='400' align='middle' allowScriptAccess='sameDomain' type='application/x-shockwave-flash'></embed>
      EMBED
    end

    private
      def extract_video_info
        return nil unless doc
        {:title => title, :video_src => video_src, :pic_path => pic_path}
      end

      def title
        doc.at_css("h1[class~='title']").inner_text.gsub(/\s/,'') rescue nil
      end

      def video_src
        doc.at_css('input[id=link2]')[:value] rescue nil
      end

      def pic_path
        begin
          pic_tag = doc.at_css('a[id=s_sina]')
          pic_tag ||= doc.at_css('a[id=s_sohu]')
          pic_param = pic_tag[:href].split("&").detect{|param|param =~ /pic=/ }
          pic_param.split("=").last
        rescue
          nil
        end
      end

  end
end
