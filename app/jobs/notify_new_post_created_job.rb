class NotifyNewPostCreatedJob < ApplicationJob
  sidekiq_options retry: 5
  queue_as :default

  def perform(*_args)
    @new_posts = Post.where(['created_at > ?', 1.minute.ago])

    FollowerMailer.notify_new_post_created(@new_posts).deliver! if @new_posts.any?
  end
end



