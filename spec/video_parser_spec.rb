require File.dirname(__FILE__) + '/spec_helper'

describe VideoParser do
  describe "youku" do
    it "v_show格式的视频地址应该能解析出正确的信息" do
      correct_info = {
        :video_src => "http://player.youku.com/player.php/sid/XMzIzMzQ0MTA0/v.swf",
        :pic_path => "http://g4.ykimg.com/0100641F464EA66CEB57FB050A7945BF6C192B-D2FE-0C76-A668-7E312C869217",
        :title => "视频:北京现代爱与梦同行"
      }
      VideoParser.get("http://v.youku.com/v_show/id_XMzIzMzQ0MTA0.html").should == correct_info
    end
    it "v_playlist格式的视频地址应该能解析出正确的信息" do
      correct_info = {
        :video_src => "http://player.youku.com/player.php/Type/Folder/Fid/16661073/Ob/1/Pt/0/sid/XMzI0NzkwNTQ4/v.swf",
        :pic_path => "http://g2.ykimg.com/01270F1F464ECA6FF944A40123193CA1419694-4596-7AE5-C968-5CE1DF4383C8",
        :title => "专辑:韩国又抓3艘中国渔船韩媒要求对中国渔船动武"
      }
      VideoParser.get("http://v.youku.com/v_playlist/f16661073o1p0.html").should == correct_info
    end
  end

  describe "tudou" do
    it "playlist格式的地址应该能解析出正确的信息" do
      correct_info = {
        :video_src => "http://www.tudou.com/l/b5tccWF-afo/&iid=112289113/v.swf",
        :pic_path => "http://i4.tdimg.com/112/289/113/p.jpg",
        :title => "暗拍交警拦运煤车赚外快"
      }
      VideoParser.get("http://www.tudou.com/playlist/p/l14450778.html").should == correct_info
    end
    it "programs格式的地址应该能解析出正确的信息" do
      correct_info = {
        :video_src => "http://www.tudou.com/v/qF_ZI0HPgig/v.swf",
        :pic_path => "http://i1.tdimg.com/112/238/874/p.jpg",
        :title => "元首版 机器猫之歌"
      }
      VideoParser.get("http://www.tudou.com/programs/view/qF_ZI0HPgig/").should == correct_info
    end
  end

  describe "slideshare" do
    it "正确的slideshare格式应该能解析出正确的信息" do
      correct_info = {
        :video_src => "http://www.slideshare.net/slideshow/embed_code/10251145",
        :title => "Professional Programmer",
        :pic_path => "http://cdn.slidesharecdn.com/craftsman2011-agileday-111121040632-phpapp02-thumbnail-2"
      }
      VideoParser.get("http://www.slideshare.net/gabriele.lana/professional-programmer").should == correct_info
    end
  end

  describe "错误的地址应该返回nil" do
    it "空地址返回nil" do
      VideoParser.get("").should be_nil
    end
    it "地址为nil返回nil" do
      VideoParser.get(nil).should be_nil
    end
    it "地址为不正确的视频地址返回nil" do
      VideoParser.get("http://www.baidu.com").should be_nil
    end
  end
end
