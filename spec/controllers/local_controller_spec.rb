require File.dirname(__FILE__) + '/../spec_helper'

describe LocalController do
  it 'front page' do
    Factory(:blog)
    get :frontpage
    response.should render_template(:frontpage)
    assigns[:page_title].should_not be_nil
  end
end
