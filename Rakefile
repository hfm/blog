task :default => :server

desc 'Clean up generated site'
task :clean do
  cleanup
end

desc 'Build site with Jekyll'
task :build => :clean do
  jekyll('build')
  gzip
end

desc 'Start server with --watch'
task :server => :clean do
  jekyll('serve --watch')
end

desc 'Start server with --watch and --drafts'
task :serverd => :clean do
  jekyll('serve --watch --drafts')
end

desc 'Deploy server'
task :deploy => :build do
  require 'dotenv'
  Dotenv.load

  sh "rsync -avz --delete -e 'ssh -p #{ENV['PORT']}' _site/ #{ENV['USERNAME']}@#{ENV['SERVER']}:/var/www/blog/"
end

desc 'Check links for site already running on localhost:4000'
task :check_links do
  begin
    require 'anemone'
    root = 'http://localhost:4000/'
    Anemone.crawl(root, :discard_page_bodies => true) do |anemone|
      anemone.after_crawl do |pagestore|
        broken_links = Hash.new { |h, k| h[k] = [] }
        pagestore.each_value do |page|
          if page.code != 200
            referrers = pagestore.pages_linking_to(page.url)
            referrers.each do |referrer|
              broken_links[referrer] << page
            end
          end
        end
        broken_links.each do |referrer, pages|
          puts "#{referrer.url} contains the following broken links:"
          pages.each do |page|
            puts "  HTTP #{page.code} #{page.url}"
          end
        end
      end
    end

  rescue LoadError
    abort 'Install anemone gem: gem install anemone'
  end
end

def cleanup
  sh 'rm -rf _site'
end

def jekyll(opts = '')
  sh 'jekyll ' + opts
end

def gzip(filename = '_site/sitemap.xml')
  require 'zlib'
  Zlib::GzipWriter.open('_site/sitemap.xml.gz', Zlib::BEST_COMPRESSION) do |gz|
    gz.mtime     = File.mtime(filename)
    gz.orig_name = 'sitemap.xml'
    gz.puts File.open(filename, 'rb') {|f| f.read}
  end
end
