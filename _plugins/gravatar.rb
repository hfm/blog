require 'digest/md5'

module Jekyll
  module GravatarFilter
    def gravatar(email)
      "<img src=\"http://www.gravatar.com/avatar/#{hash(email)}?s=64\" width=\"32px\" height=\"32px\">"
    end

    private

    def hash(email)
      Digest::MD5.hexdigest(email.downcase.strip)
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)
