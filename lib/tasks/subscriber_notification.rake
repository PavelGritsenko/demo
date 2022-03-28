require 'rake'
namespace :subscriber_notification do
  desc 'Sends notification about new post was created'
    task new_post_created: :environment do
      NotifyNewPostCreatedJob.perform_now
    end
end