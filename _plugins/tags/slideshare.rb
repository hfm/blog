module Jekyll
  class SlideShareTag < Liquid::Tag
    def initialize(tag_name, data_id, tokens)
      super
      @arg = data_id.strip
    end

    def render(context)
      %|<p><iframe src="//www.slideshare.net/slideshow/embed_code/#{@arg}" width="597" height="486" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #ccc;border-width:1px 1px 0;margin-bottom:5px max-width: 100%;" allowfullscreen> </iframe></p>|
    end
  end
end

Liquid::Template.register_tag('slideshare', Jekyll::SlideShareTag)
