require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
	
	test "/login opens the login page" do 
		get '/login'
		assert_response :success
	end

	test "/join shows the signup page" do 
		get '/join'
		assert_response :success
	end

	test "/logout closes the user session" do 
		get '/logout'
		assert_response :redirect
		assert_redirected_to '/'
	end

	test "a profile page works" do 
		get '/zaziz'
		assert_response :success
	end
	
end
