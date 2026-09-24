class Admin::ArtworksController < Admin::BaseController
  def index
    @artworks = Artwork.order(created_at: :desc)
  end
end
