require 'spec_helper'

describe Post do

  require 'spec_helper'

  describe "default_permalink" do

    let(:post) { FactoryGirl.build_stubbed(:post) }

    it "should generate permalink based on parametrized title" do
      post.default_permalink.should include post.title.parameterize
    end

    it "should generate unique permalinks for posts with same title" do
      post_2 = FactoryGirl.build_stubbed(:post, title: post.title)
      post.default_permalink.should_not == post_2.default_permalink
    end

  end

end