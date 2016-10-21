require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  attr_reader :micropost

  class NotLoggedInTest < self
    setup do
      @micropost = microposts(:orange)
    end

    test "redirects create" do
      assert_no_difference 'Micropost.count' do
        post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
      end
      assert_redirected_to login_url
    end

    test "redirects destroy" do
      assert_no_difference 'Micropost.count' do
        delete micropost_path(micropost)
      end
      assert_redirected_to login_url
    end
  end

  class LoggedInTest < self
    setup do
      @micropost = microposts(:ants)
      log_in_as(users(:michael))
    end

    test "redirects destroy for wrong micropost" do
      assert_no_difference 'Micropost.count' do
        delete micropost_path(micropost)
      end
      assert_redirected_to root_url
    end
  end
end
