require "test_helper"

class ArtworkTest < ActiveSupport::TestCase
  test "requires a title" do
    artwork = Artwork.new
    assert_not artwork.valid?
    assert_includes artwork.errors[:title], "can't be blank"
  end

  test "generates a slug from the title when left blank" do
    artwork = Artwork.new(title: "Hello, World!")
    artwork.valid?
    assert_equal "hello-world", artwork.slug
  end

  test "appends a numeric suffix when the generated slug is already taken" do
    artwork = Artwork.new(title: artworks(:one).title)
    artwork.valid?
    assert_equal "quiet-morning-2", artwork.slug
  end

  test "sets published_at when published for the first time" do
    artwork = Artwork.create!(title: "Announcing Something", published: true)
    assert_not_nil artwork.published_at
  end

  test "published scope only includes published artwork" do
    assert_includes Artwork.published, artworks(:one)
    assert_not_includes Artwork.published, artworks(:two)
  end

  test "can have an image attached" do
    artwork = artworks(:one)
    artwork.image.attach(io: StringIO.new("fake image content"), filename: "test.png", content_type: "image/png")
    assert artwork.image.attached?
  end
end
