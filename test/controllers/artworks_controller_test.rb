require "test_helper"

class ArtworksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artwork = artworks(:one)
  end

  test "should get index" do
    get artworks_url
    assert_response :success
  end

  test "should redirect new to sign in when not an admin" do
    get new_artwork_url
    assert_redirected_to new_admin_session_url
  end

  test "should get new when signed in as admin" do
    sign_in admins(:one)
    get new_artwork_url
    assert_response :success
  end

  test "should not create artwork when not an admin" do
    assert_no_difference("Artwork.count") do
      post artworks_url, params: { artwork: {} }
    end

    assert_redirected_to new_admin_session_url
  end

  test "should create artwork when signed in as admin" do
    sign_in admins(:one)

    assert_difference("Artwork.count") do
      post artworks_url, params: { artwork: { title: "New Artwork" } }
    end

    assert_redirected_to admin_url
  end

  test "should redirect edit to sign in when not an admin" do
    get edit_artwork_url(@artwork)
    assert_redirected_to new_admin_session_url
  end

  test "should get edit when signed in as admin" do
    sign_in admins(:one)
    get edit_artwork_url(@artwork)
    assert_response :success
  end

  test "should not update artwork when not an admin" do
    patch artwork_url(@artwork), params: { artwork: {} }
    assert_redirected_to new_admin_session_url
  end

  test "should update artwork when signed in as admin" do
    sign_in admins(:one)
    patch artwork_url(@artwork), params: { artwork: { title: "Updated Title" } }
    assert_redirected_to admin_url
  end

  test "should not destroy artwork when not an admin" do
    assert_no_difference("Artwork.count") do
      delete artwork_url(@artwork)
    end

    assert_redirected_to new_admin_session_url
  end

  test "should destroy artwork when signed in as admin" do
    sign_in admins(:one)

    assert_difference("Artwork.count", -1) do
      delete artwork_url(@artwork)
    end

    assert_redirected_to artworks_url
  end
end
