require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  
  test "should get show" do
    get :show, id: users(:heuburt).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "render 404 on profile not found" do
  	get :show, id: "doesn't exist" 
  	assert_response :not_found
  end

  test "variables are assigned on successful profile viewing" do 
  	get :show, id: users(:heuburt).profile_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses) 
  end

  test "only correct statuses are shown for a user" do 
  	get :show, id: users(:heuburt).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:heuburt), status.user
  	end
  end
end
