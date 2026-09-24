require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should redirect new to sign in when not an admin" do
    get new_project_url
    assert_redirected_to new_admin_session_url
  end

  test "should get new when signed in as admin" do
    sign_in admins(:one)
    get new_project_url
    assert_response :success
  end

  test "should not create project when not an admin" do
    assert_no_difference("Project.count") do
      post projects_url, params: { project: {} }
    end

    assert_redirected_to new_admin_session_url
  end

  test "should create project when signed in as admin" do
    sign_in admins(:one)

    assert_difference("Project.count") do
      post projects_url, params: { project: { title: "New Project" } }
    end

    assert_redirected_to admin_url
  end

  test "should create project with nested features when signed in as admin" do
    sign_in admins(:one)

    assert_difference([ "Project.count", "Feature.count" ], 1) do
      post projects_url, params: { project: {
        title: "Nested Features Project",
        features_attributes: {
          "0" => { title: "Only feature", description: "do the thing" }
        }
      } }
    end

    project = Project.last
    assert_redirected_to admin_url
    assert_equal [ "Only feature" ], project.features.map(&:title)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should not show a draft project to the public" do
    get project_url(projects(:two))
    assert_response :not_found
  end

  test "should show a draft project to an admin" do
    sign_in admins(:one)
    get project_url(projects(:two))
    assert_response :success
  end

  test "index should not list draft projects to the public" do
    get projects_url
    assert_select "##{ActionView::RecordIdentifier.dom_id(projects(:two))}", false
  end

  test "index should list draft projects to an admin" do
    sign_in admins(:one)
    get projects_url
    assert_select "##{ActionView::RecordIdentifier.dom_id(projects(:two))}"
  end

  test "should redirect edit to sign in when not an admin" do
    get edit_project_url(@project)
    assert_redirected_to new_admin_session_url
  end

  test "should get edit when signed in as admin" do
    sign_in admins(:one)
    get edit_project_url(@project)
    assert_response :success
  end

  test "should not update project when not an admin" do
    patch project_url(@project), params: { project: {} }
    assert_redirected_to new_admin_session_url
  end

  test "should update project when signed in as admin" do
    sign_in admins(:one)
    patch project_url(@project), params: { project: { title: "Updated Title" } }
    assert_redirected_to admin_url
  end

  test "should not destroy project when not an admin" do
    assert_no_difference("Project.count") do
      delete project_url(@project)
    end

    assert_redirected_to new_admin_session_url
  end

  test "should destroy project when signed in as admin" do
    sign_in admins(:one)

    assert_difference("Project.count", -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end

  test "should destroy project and return to return_to param when signed in as admin" do
    sign_in admins(:one)

    assert_difference("Project.count", -1) do
      delete project_url(@project), params: { return_to: admin_path }
    end

    assert_redirected_to admin_url
  end
end
