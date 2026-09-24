class PagesController < ApplicationController
  def about
    @recent_projects = Project.published.includes(:technologies).limit(3)
    @recent_artworks = Artwork.published.limit(3)
    @recent_posts = Post.published.limit(2)
  end

  def resume
  end
end
