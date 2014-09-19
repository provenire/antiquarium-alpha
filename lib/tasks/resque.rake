require 'resque/tasks'

task "resque:setup" => :environment

namespace :resque do
  PublicActivity.enabled = false
end