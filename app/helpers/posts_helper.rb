module PostsHelper
  #判断给定的Post是否有新回复
  def new_comments?(post)
    last_updated_at = post.updated_at.strftime('%Y%m%d %H:%M:%S')
    cookie_updated_at = cookies["post_#{post.id}_last_updated_at"]
    cookie_updated_at ||= 12.months.ago.strftime('%Y%m%d %H:%M:%S')
    last_updated_at > cookie_updated_at
  end
end
