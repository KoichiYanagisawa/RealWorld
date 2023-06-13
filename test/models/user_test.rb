require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    User.delete_all
  end

  test 'should not save user' do
    @user1 = User.new(username: 'hakasetaro', email: '', password: 'hakahakase')
    @user2 = User.new(username: 'hakasetaro', email: 'hakase@example.com', password: '')
    @user3 = User.new(username: '', email: 'hakase@example.com', password: 'hakahakase')
    refute @user1.valid?
    refute @user2.valid?
    refute @user3.valid?
  end

  test 'should save user' do
    @user4 = User.new(username: 'hakasetaro', email: 'hakase@example.com', password: 'hakahakase')
    assert @user4.valid?
  end
end
