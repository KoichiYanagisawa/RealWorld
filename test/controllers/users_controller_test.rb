require 'test_helper'
require 'json'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.delete_all
  end

  test 'should create user with valid request' do
    post users_url, params: {
      user: {
        username: 'hakasetaro',
        email: 'hakase@example.com',
        password: 'hakahakase'
      }
    }
    assert_response :success
    assert_equal 'hakasetaro', JSON.parse(@response.body)['user']['username']
  end

  test 'should not create user with invalid request' do
    post users_url, params: {
      user: {
        username: 'josyunojiro',
        password: 'jojojosyu'
      }
    }
    assert_response :unprocessable_entity
    assert_nil JSON.parse(@response.body)['user']
  end
end
