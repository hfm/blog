module Jekyll
  class SpeakerDeckTag < Liquid::Tag

    SYNTAX_EXAMPLE = "{% speakerdeck 11111111111111111111111111111111 ratio=1 %}"
    SYNTAX = /\A\s*([^\s]+)(?:\s+ratio=([\d\.]+)\s*)?/

    def initialize(tag_name, args, tokens)
      super
      if m = args.match(SYNTAX)
        @data_id    = m[1]
        @data_ratio = m[2].nil? ? 1.33333333333333 : m[2].to_f
      end
    end

    def render(context)
      embed_code
    end

    def embed_code
      %|<p><script async class="speakerdeck-embed" data-id="#{@data_id}" data-ratio="#{@data_ratio}" src="//speakerdeck.com/assets/embed.js"></script></p>|
    end
  end
end

Liquid::Template.register_tag('speakerdeck', Jekyll::SpeakerDeckTag)
