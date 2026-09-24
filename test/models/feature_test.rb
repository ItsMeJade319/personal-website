require "test_helper"

class FeatureTest < ActiveSupport::TestCase
  test "requires a title" do
    feature = Feature.new
    assert_not feature.valid?
    assert_includes feature.errors[:title], "can't be blank"
  end

  test "belongs to a project" do
    assert_equal projects(:one), features(:one).project
  end
end
