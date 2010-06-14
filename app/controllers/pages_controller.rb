class PagesController < ApplicationController

  def home
    @title = "Forum"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

end
