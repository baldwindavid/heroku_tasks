# code from Eli Miller
# See blog post: http://jqr.github.com/2009/04/24/deploy-your-rails-application-in-2-minutes-with-heroku.html

namespace :heroku do
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
end
