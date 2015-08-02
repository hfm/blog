desc 'Deploy server'
task :deploy do
  require 'dotenv'
  Dotenv.load

  sh "make && rsync -rlpgoDcv --delete -e 'ssh -p #{ENV['PORT']}' public/ #{ENV['USERNAME']}@#{ENV['SERVER']}:/var/www/blog/"
end
