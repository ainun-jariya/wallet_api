# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_user
    # user = User.new users(:one).to_h # already an object of User
    # assert user.save

    user1 = User.find(users(:one).id)
    assert_equal user1.id, users(:one).id

    user1.name = 'Other name'
    assert user1.save
    assert user1.destroy
  end
end
