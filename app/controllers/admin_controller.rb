class AdminController < ApplicationController
  before_action :authenticate_admin!

  def show
    @projects = Project.order(created_at: :desc)
    @artworks = Artwork.order(created_at: :desc)
    @posts = Post.order(created_at: :desc)
    @recent_projects = @projects.first(4)
    @recent_artworks = @artworks.first(4)
    @recent_posts = @posts.first(4)
    @drafts = (@projects.to_a + @artworks.to_a + @posts.to_a).reject(&:published?).sort_by(&:created_at).reverse
  end
end
