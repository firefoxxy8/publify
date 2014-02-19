require File.dirname(__FILE__) + '/../spec_helper'

describe LocalController do
  render_views

  it 'front page' do
    create :blog
    get :frontpage
    response.should render_template(:frontpage)
    assigns[:page_title].should_not be_nil
  end
end
