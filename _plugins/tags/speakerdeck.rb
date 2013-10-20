module Jekyll
  class SpeakerDeckTag < Liquid::Tag
    def initialize(tag_name, data_id, tokens)
      super
      @arg = data_id.strip
    end

    def render(context)
      %|<p><script async class="speakerdeck-embed" data-id="#{@arg}" src="//speakerdeck.com/assets/embed.js"></script></p>|
    end
  end
end

Liquid::Template.register_tag('speakerdeck', Jekyll::SpeakerDeckTag)
