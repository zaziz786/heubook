require 'test_helper'

class StatusTest < ActiveSupport::TestCase

	test "status requires content" do 
		status = Status.new
		assert !status.save
		assert !status.errors[:content].empty?
	end

	test "content is atleast two letters long" do 
		status = Status.new
		status.content = "H"
		assert !status.save
		assert !status.errors[:content].empty?
	end

	test "status has a user id" do 
		status = Status.new
		status.content = "Hello"
		assert !status.save
		assert !status.errors[:user_id].empty?
	end

end
