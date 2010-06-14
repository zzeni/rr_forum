module PostsHelper
  # show the posts navigation buttons
  def navigation_buttons(post)
    spacer = content_tag(:div, "", :class => "spacer")

    return spacer unless signed_in?
    return spacer unless (post.user == current_user or current_user.admin?)

    unless current_user.admin?
      return spacer if (post.is_a?(Topic) and post.locked)
      return spacer if (post.is_a?(Post) and post.topic.locked)
    end

    if post.is_a?(Topic)
      edit_link = link_to image_tag("edit.gif", :alt => "Edit topic"), edit_topic_path(post)
      delete_link = link_to image_tag("delete.gif", :alt => "Delete topic"), topic_path(post), :method => :delete, :confirm => "You sure?"
    else
      edit_link = link_to image_tag("edit.gif", :alt => "Edit post"), edit_post_path(post)
      delete_link = link_to image_tag("delete.gif", :alt => "Delete post"), post_path(post), :method => :delete, :confirm => "You sure?"
    end

    content_tag(:div, edit_link + spacer + delete_link, :class => "post_navigation")

  end
end
