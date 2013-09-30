module Jekyll
  module SpeakerDeckFilter
    def speakerdeck(data_id)
      %|<p><script async class="speakerdeck-embed" data-id="#{data_id}" src="//speakerdeck.com/assets/embed.js"></script></p>|
    end
  end
end

Liquid::Template.register_filter(Jekyll::SpeakerDeckFilter)
