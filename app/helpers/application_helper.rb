# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "One ugly forum"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end

  def logo
    image_tag("forum.png", :alt => "Sample App", :class => "round", :id => "main_logo")
  end

  def summary(this)
    summary = content_tag(:div, this.summary, :class => "summary")
    if this.locked?
      locked_img = image_tag("locked.gif", :alt => this.class.to_s.downcase + " locked")
      locked_div = content_tag(:div, locked_img, :class => "locked")
    end
    summary + " " + locked_div
  end

  def navigation_buttons(post)
    if !current_user.nil? and (post.user == current_user or current_user.admin?)
      if post.is_a?(Topic)
        edit_link = link_to image_tag("edit.gif", :alt => "Edit topic"), edit_topic_path(post)
        delete_link = link_to image_tag("delete.gif", :alt => "Delete topic"), topic_path(post), :method => :delete, :confirm => "You sure?"
      else
        edit_link = link_to image_tag("edit.gif", :alt => "Edit post"), edit_post_path(post)
        delete_link = link_to image_tag("delete.gif", :alt => "Delete post"), post_path(post), :method => :delete, :confirm => "You sure?"
      end
      spacer = content_tag(:div, "", :class => "spacer")
      content_tag(:div, edit_link + spacer + delete_link, :class => "post_navigation")

    end
  end


end
