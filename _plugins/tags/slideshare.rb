module Jekyll
  class SlideShareTag < Liquid::Tag
    def initialize(tag_name, data_id, tokens)
      super
      @arg = data_id.strip
    end

    def render(context)
      %|<iframe src="http://www.slideshare.net/slideshow/embed_code/25976004?startSlide=29" width="597" height="486" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="https://www.slideshare.net/cohama/vim-script-vimrc-nagoyavim-1" title="Vim script と vimrc の正しい書き方＠nagoya.vim #1" target="_blank">Vim script と vimrc の正しい書き方＠nagoya.vim #1</a> </strong> from <strong><a href="http://www.slideshare.net/cohama" target="_blank">cohama</a></strong> </div>|
# [slideshare id=25976004&doc=vim-20script-20-e3-81-a8-20vimrc-20-e3-81-ae-e6-ad-a3-e3-81-97-e3-81-84-e6-9b-b8-e3-81-8d-e6-96-b9-e-130907003517-]
    end
  end
end

Liquid::Template.register_tag('slideshare', Jekyll::SlideShareTag)
