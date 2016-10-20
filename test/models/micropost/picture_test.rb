require 'test_helper'

class Micropost::PictureTest < ActiveSupport::TestCase
  attr_reader :micropost, :picture

  setup do
    @micropost = Micropost.new(user: users(:michael), content: "Content")
    @picture =
      Rack::Test::UploadedFile.new(
        File.join(
          ActionDispatch::IntegrationTest.fixture_path,
          "files/paul.jpg"
        ),
        "image/jpg"
      )
  end

  class PictureWithinSizeRestrictionTest < self
    test "picture under 5 MB" do
      micropost.picture = picture
      assert micropost.valid?
    end
  end

  class PictureOverSizeRestrictionTest < self
    test "picture over 5 MB" do
      micropost.picture = picture
      micropost.picture.stub(:size, 6.megabytes) do
        assert_not micropost.valid?
      end
    end
  end
end
