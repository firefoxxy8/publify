require File.dirname(__FILE__) + '/../spec_helper'

describe "a valid Article" do
  before(:each) do
    @blog = mock_model(Blog)
    @a = Article.new(:title => 'Test article', :body => 'body',
                     :author => mock_model(User), :blog => @blog)
  end

  it "should be valid" do
    @blog.should_receive(:default_allow_comments)
    @blog.should_receive(:default_allow_pings)
    @a.should be_valid
  end

  it "should cast #published = '0' to false" do
    @a.published = '0'
    @a.published.should == false
  end
end
