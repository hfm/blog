require 'digest/md5'

module Jekyll
  module GravatarFilter
    def gravatar(email)
      "<img src=\"http://www.gravatar.com/avatar/#{hash(email)}?s=128\" width=\"64px\" height=\"64px\">"
    end

    private

    def hash(email)
      Digest::MD5.hexdigest(email.downcase.strip)
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)
