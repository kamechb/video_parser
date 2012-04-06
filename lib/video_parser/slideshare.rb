require 'video_parser/video_site'

module VideoParser
  class SlideShare < VideoSite
    VideoHost = "www.slideshare.net"
    def self.embed_html(video_src )
      <<-EMBED
        <div style='width:425px'>
          <iframe src='#{video_src}' width='425' height='355' frameborder='0' marginwidth='0' marginheight='0' scrolling='no'></iframe>
        </div>
      EMBED
    end
    private
      def extract_video_info
        return nil unless doc
        {:title => title, :video_src => video_src, :pic_path => pic_path}
      end

      # <meta name="og_title" property="og:title" content="Professional Programmer" />
      def title
        doc.at_css('meta[name~=og_title]')[:content] rescue nil
      end

      # video src is in script content with iframe_url attribute
      def video_src
        doc.at_css('script[id~=page-json]').inner_text =~ /['"]iframe_url['"]\:\s*?['"](.*?)['"],/
        $1
        rescue
        nil
      end

      # pic path is in meta tag with name="og_image"
      def pic_path
        doc.at_css('meta[name~=og_image]')[:content] rescue nil
      end

  end
end
