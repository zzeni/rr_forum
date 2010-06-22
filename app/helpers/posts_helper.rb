module PostsHelper
  # show the posts navigation buttons
  def navigation_buttons(post)
    spacer = content_tag(:div, "", :class => "spacer")

    return spacer unless signed_in?

    unless current_user.admin?
      return spacer if (post.is_a?(Topic) and post.locked)
      return spacer if (post.is_a?(Post) and post.topic.locked)
    end

    nav_buttons = ""

    unless post.user == current_user
      topic  = post.is_a?(Topic) ? post : post.topic
      quoted = post.is_a?(Topic) ? "self" : post.id
      nav_buttons = link_to image_tag("quote16x16.png", :alt => "Quote post"), new_post_path(:topic => topic, :quoted => quoted)
      nav_buttons += spacer
      nav_buttons += link_to image_tag("send_pm.png", :alt => "Send pm to user"), new_message_path(:user => post.user)

      return content_tag(:div, nav_buttons, :class => "post_navigation") unless current_user.admin?

      nav_buttons += spacer
    end

    if post.is_a?(Topic)
      edit_link = link_to image_tag("edit.gif", :alt => "Edit topic"), edit_topic_path(post)
      delete_link = link_to image_tag("delete.gif", :alt => "Delete topic"), topic_path(post), :method => :delete, :confirm => "You sure?"
    else
      edit_link = link_to image_tag("edit.gif", :alt => "Edit post"), edit_post_path(post)
      delete_link = link_to image_tag("delete.gif", :alt => "Delete post"), post_path(post), :method => :delete, :confirm => "You sure?"
    end

    nav_buttons += edit_link + spacer + delete_link

    content_tag(:div, nav_buttons, :class => "post_navigation")

  end

  def integrate_qutes(text)
    text.gsub(/\{:quote title=(.*)\}/, '<div class="quote"><span class="title">\1</span>').gsub("{quote:}", '</div>')
  end
end
