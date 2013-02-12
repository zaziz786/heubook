require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many(:user_friendships)
	should have_many(:friends)

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

	test "that no error is raised when trying to access a friend list" do 
		assert_nothing_raised do
			users(:heuburt).friends
		end
	end

	test "that creating friendships on a user works" do 
		users(:heuburt).friends << users(:john)
		users(:heuburt).friends.reload

		assert users(:heuburt).friends.include?(users(:john))
	end

	test "that creating a friendship based on user id and friend id works" do 
		UserFriendship.create user_id: users(:heuburt).id, friend_id: users(:john).id

		assert users(:heuburt).friends.include?(users(:john))
	end
end
