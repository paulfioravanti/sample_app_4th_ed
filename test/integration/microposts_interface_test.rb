require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    @user = users(:michael)
    log_in_as(user)
    get root_path
    assert_select "div.pagination"
    assert_select 'input[type=file]'
    assert_match "34 microposts", response.body
  end

  class InvalidSubmissionTest < self
    test "shows an error" do
      assert_no_difference "Micropost.count" do
        post microposts_path, params: { micropost: { content: "" } }
      end
      assert_select "div.error-explanation"
    end
  end

  class ValidSubmissionTest < self
    attr_reader :content, :picture, :params

    setup do
      @content = "This micropost really ties the room together"
      @picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
      @params = { micropost: { content: content, picture: picture } }
    end

    test "sucessfully submits micropost" do
      assert_difference "Micropost.count", 1 do
        post microposts_path, params: params
      end
      assert Micropost.find_by(content: content).picture?
      assert_redirected_to root_url
      follow_redirect!
      assert_match content, response.body
    end

    class DeletingAMicropostTest < self
      attr_reader :first_micropost

      setup do
        @first_micropost = user.microposts.paginate(page: 1).first
      end

      test "successful micropost deletion" do
        assert_select "a", text: "delete"
        assert_difference "Micropost.count", -1 do
          delete micropost_path(first_micropost)
        end
      end
    end
  end

  class VisitingDifferentUserTest < self
    setup do
      get user_path(users(:archer))
    end

    test "no delete links" do
      assert_select "a", text: "delete", count: 0
    end
  end

  class SidebarCountTest < self
    attr_reader :other_user

    setup do
      @other_user = users(:malory)
      log_in_as(other_user)
      get root_path
    end

    class ZeroMicropostsTest < self
      test "shows 0 microposts" do
        assert_match "0 microposts", response.body
      end
    end

    class OneMicropostTest < self
      setup do
        other_user.microposts.create!(content: "A micropost")
        get root_path
      end

      test "shows 1 micropost" do
        assert_match "1 micropost", response.body
      end
    end
  end
end
