module Jekyll
  class SlideShareTag < Liquid::Tag

    SYNTAX_EXAMPLE = "{% slideshare 123456 height=600 width=400 start=1 %}"
    SYNTAX = /\A\s*([^\s]+)(?:\s+width=(\d+)\s+height=(\d+)\s*(?:start=(\d+))?\s*)?/

    def initialize(tag_name, args, tokens)
      super

      if m = args.match(SYNTAX)
        @slide_id    = m[1].to_i
        @width       = m[2].nil? ? 597 : m[2].to_i
        @height      = m[3].nil? ? 486 : m[3].to_i
        @start_slide = m[4].nil? ? 1   : m[4].to_i
      end

    end

    def render(context)
      embed_code
    end

    def embed_code
      %|<p><iframe src="#{src_url}" width="#{@width}" height="#{@height}" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #ccc;border-width:1px;margin-bottom:5px max-width: 100%;" allowfullscreen> </iframe></p>|
    end

    def src_url
      url = "//www.slideshare.net/slideshow/embed_code/#{@slide_id}"
      url << "?startSlide=#{@start_slide}" unless @start_slide.between?(0, 1)
      url
    end
  end
end

Liquid::Template.register_tag('slideshare', Jekyll::SlideShareTag)
