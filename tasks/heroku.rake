namespace :heroku do
  
  # code from Eli Miller
  # See blog post: http://jqr.github.com/2009/04/24/deploy-your-rails-application-in-2-minutes-with-heroku.html
  desc "Generate the Heroku gems manifest from gem dependencies"
  task :gems do
    RAILS_ENV='production'
    Rake::Task[:environment].invoke
    list = Rails.configuration.gems.collect do |g| 
      command, *options = g.send(:install_command)
      options.join(" ") + "\n"
    end
    
    File.open(File.join(RAILS_ROOT, '.gems'), 'w') do |f|
      f.write(list)
    end
  end
  
  # code from Trevor Turk
  # See blog post: http://almosteffortless.com/2009/06/25/config-vars-and-heroku/
  desc "Send config vars from yml up to Heroku ENV vars"
  task :config do
    puts "Reading config/config.yml and sending production configuration variables to Heroku..."
    CONFIG = YAML.load_file('config/config.yml')['production'] rescue {}
    command = "heroku config:add"
    CONFIG.each {|key, val| command << " #{key}=#{val} " if val }
    system command  
  end
  
end
