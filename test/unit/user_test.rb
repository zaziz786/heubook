require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "User should enter first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "User should enter last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "User should enter profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "User should have unique profile name" do
		user = User.new
		user.profile_name = users(:heuburt).profile_name
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "User should have a profile name without spaces" do 
		user = User.new(first_name: 'Heuburt', last_name: 'Bee', email: 'heuburt1@heubee.com')
		user.password = user.password_confirmation = 'asdfasdf'
		user.profile_name = "Profile Name With Spaces"
		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.")
	end

	test "Correctly formatted profile name" do 
		user = User.new(first_name: 'Heuburt', last_name: 'Bee', email: 'heuburt1@heubee.com')
		user.password = user.password_confirmation = 'asdfasdf'

		user.profile_name = 'zaziz7'
		assert user.valid?
	end

end
