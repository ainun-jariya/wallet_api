# frozen_string_Literal: true

require 'test_helper'

module Api
  class UsersControllerTest < ActionDispatch::IntegrationTest
    fixtures :users

    def test_create
      post api_users_path, params: { user:
        { name: users(:one).name, email: users(:one).email, phone: users(:one).phone } }
      assert_response :success
    end

    def test_update
      patch api_user_path(users(:two).id), params: { user:
        { name: users(:one).name, email: users(:one).email, phone: users(:one).phone } }
      assert_response :success
    end

    def test_destroy
      delete api_user_path(users(:one).id)
      assert_response :success
    end

    def test_not_found
      get api_user_path(-1)
      assert_response :missing
      patch api_user_path(-1)
      assert_response :missing
      delete api_user_path(-1)
      assert_response :missing
    end

    def test_presence_of_name
      patch api_user_path(users(:two).id), params: { user:
        { name: nil, email: users(:one).email, phone: users(:one).phone } }
      assert 'can\'t be blank'
      assert_response 422
    end

    def test_presence_of_email
      patch api_user_path(users(:two).id), params: { user:
        { name: users(:one).name, email: nil, phone: users(:one).phone } }
      # assert 'can\'t be blank'
      assert_response 422
    end

    def test_format_of_email
      patch api_user_path(users(:two).id), params: { user:
        { name: users(:one).name, email: users(:one).name, phone: users(:one).phone } }
      # assert 'is invalid'
      assert_response 422
    end

    def test_format_of_phone
      patch api_user_path(users(:two).id), params: { user:
        { name: users(:one).name, email: users(:one).email, phone: 'users(:one).phone' } }
      # assert 'is invalid'
      assert_response 422
    end
  end
end
