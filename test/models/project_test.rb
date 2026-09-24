require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "requires a title" do
    project = Project.new
    assert_not project.valid?
    assert_includes project.errors[:title], "can't be blank"
  end

  test "generates a slug from the title when left blank" do
    project = Project.new(title: "Hello, World!")
    project.valid?
    assert_equal "hello-world", project.slug
  end

  test "appends a numeric suffix when the generated slug is already taken" do
    project = Project.new(title: projects(:one).title)
    project.valid?
    assert_equal "build-a-personal-website-2", project.slug
  end

  test "sets published_at when published for the first time" do
    project = Project.create!(title: "Announcing Something", published: true)
    assert_not_nil project.published_at
  end

  test "published scope only includes published projects" do
    assert_includes Project.published, projects(:one)
    assert_not_includes Project.published, projects(:two)
  end

  test "can have an image attached" do
    project = projects(:one)
    project.image.attach(io: StringIO.new("fake image content"), filename: "test.png", content_type: "image/png")
    assert project.image.attached?
  end

  test "orders features by position" do
    assert_equal [ features(:one), features(:two) ], projects(:one).features.to_a
  end
end
