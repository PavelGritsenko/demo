class FollowerMailer < ApplicationMailer
  default from: 'demo@mail.com'

  def notify_new_post_created(new_posts)
    @new_posts = new_posts
    authors = []
    followers = {}
    # @url =
    new_posts.each do |post|
      authors << User.find(post[:user_id])
    end
    authors.uniq.each do |author|
      follow_pairs = Follow.all
      fo = []
      follow_pairs.each do |follow_pair|
        if follow_pair[:followee_id] != author[:id] then
          next
        else
          fo << User.find(follow_pair[:follower_id])[:email]
        end
      end
      followers[author[:id]] = fo
    end
    followers.each_value do |emails|
      emails.each do |email|
        mail(
          to: email,
          bcc: ["noreply@example.com"],
          subject: "New Post"
        )
      end
    end
  end
end
