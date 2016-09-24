require 'test_helper'

class UserDecorator::GravatarTest < Draper::TestCase
  attr_reader :user, :size, :gravatar_url,
              :gravatar_service_mock, :image_tag_mock

  def setup
    @user = UserDecorator.decorate(
      User.new(
        name: "Example User",
        email: "user@example.com",
        password: "foobar",
        password_confirmation: "foobar"
      )
    )
    @size = 80
    @gravatar_url = "https://secure.gravatar.com/avatar/abc123?s=80"
    @gravatar_service_mock =
      Minitest::Mock.new.expect(
        :call,
        gravatar_url,
        [user.email.downcase, { size: size }]
      )
    @image_tag_mock =
      Minitest::Mock.new.expect(
        :call,
        :image_tag_html,
        [gravatar_url, { alt: user.name, class: "gravatar" }]
      )
  end

  test "#gravatar_image" do
    actual = -> { user.gravatar_image(size: size) }
    Gravatar.stub(:url, gravatar_service_mock) do
      user.helpers.stub(:image_tag, image_tag_mock) do
        actual.call
      end
    end
    image_tag_mock.verify
  end
end
